module Documentation::API::V1::TagsControllerDoc
  extend ActiveSupport::Concern

  included do

    swagger_controller 'Tags', 'Tags index'

    # GET api/v1/tags.json
    swagger_api :index do |api|
      summary 'Fetches all Tags'
      notes 'This lists all Tags availables'
      API::V1::BaseController::index_common_params(api)
      response :ok
      response :requested_range_not_satisfiable
    end

  end

end