module Documentation::API::V1::BaseControllerDoc
  extend ActiveSupport::Concern

  module ClassMethods

    def index_common_params(api, options = {})
      options = {search: true}.merge(options)
      api.param :query, :page, :integer, :optional, "Page number"
      api.param :query, :per_page, :integer, :optional, "Per page number"
      api.param :query, :q, :string, :optional, "Q search" if options[:search]
    end

  end

end