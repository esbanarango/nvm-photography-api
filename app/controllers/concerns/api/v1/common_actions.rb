module API::V1::CommonActions
  extend ActiveSupport::Concern

  protected

  def common_index(active_model, options = {})
    respond_with(*respond_with_array(active_model, options))
  end

  def respond_with_array(active_model, options = {})
    options = {api_template: :default, sorted_model: active_model}.merge(options)

    @active_model_instance = apply_options(active_model, options)
    @active_model_instance = @active_model_instance.order(sort_order(options[:sorted_model], options[:sorting_default]))
    @active_model_instance = @active_model_instance.page(params[:page]).per(per_page)

    [:api, :v1, @active_model_instance, api_template: options[:api_template], meta: meta_data]
  end

  private

  def apply_options(active_model, options)
    active_model_on_query = active_model
    active_model_on_query = active_model_on_query.includes(options[:include]) if options[:include]
    active_model_on_query = active_model_on_query.joins(options[:join]) if options[:join]
    active_model_on_query = active_model_on_query.search(params[:q]) if active_model.respond_to?(:search)
    active_model_on_query
  end

  def meta_data
  	{meta: {page: params[:page], total_pages: @active_model_instance.total_pages, total_items: @active_model_instance.total_count} }
  end

end