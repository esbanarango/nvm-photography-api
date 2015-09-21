class ApplicationController < ActionController::API

  include Swagger::Docs::ImpotentMethods

  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::ImplicitRender
  include ActsAsApi::Rendering

  ALL_RECORDS_LIMIT = 9**10 # Big Int to return all

  self.responder = ActsAsApi::Responder
  respond_to :json

  helper_method :per_page, :sort_order

  protected

  def per_page
    if params[:per_page] == 'all' || params[:per_page] == 'NaN'
      ALL_RECORDS_LIMIT
    else
      params[:per_page] || 10
    end
  end

  def sort_order(active_model, sorting_default = nil)
    sorting = []
    sorting_default = sort_column(active_model, sorting_default)
    sorting << sorting_default + ' ' + sort_direction if sorting_default
    sorting << "#{active_model.table_name}.updated_at" + ' ' + sort_direction unless %w(tags).include?(active_model.table_name)
    sorting.uniq.join(', ')
  end

  private

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column(active_model, default)
    sort = "#{active_model.table_name}.#{params[:sort]}"
    column_names = active_model.column_names.map { |column| "#{active_model.table_name}.#{column}" }
    column_names.include?(sort) ? sort : default
  end

end