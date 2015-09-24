class API::V1::TagsController < API::V1::BaseController

  include API::V1::CommonActions
  # Documentation
  include Documentation::API::V1::TagsControllerDoc

  before_filter :authenticate_user!

	# GET api/v1/tags.json
  def index
  	common_index Tag, sorting_default: 'name'
  end
end
