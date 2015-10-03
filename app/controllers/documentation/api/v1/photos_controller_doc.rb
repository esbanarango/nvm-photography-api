module Documentation::API::V1::PhotosControllerDoc
  extend ActiveSupport::Concern

  module ClassMethods

    def add_common_params(api, action = :create )
      bond = (action == :create) ? :required : :optional
      api.param :form, 'photo[description]', :string, bond, 'Description'
      api.param :form, 'photo[image]', :file, bond, 'Image file'
      api.param :form, 'photo[aperture]', :string, :optional, 'Aperture'
      api.param :form, 'photo[exposure]', :string, :optional, 'Exposure'
      api.param :form, 'photo[iso]', :integer, :optional, 'ISO'
      api.param :form, 'photo[shutter_speed]', :string, :optional, 'Shutter speed'
      api.param :form, 'photo[color_space]', :boolean, :optional, 'Color space'
      api.param :form, 'photo[focal_length]', :datetime, :optional, 'Focal length'
      api.param :form, 'photo[tag_list]', :string, :optional, 'Tags (comma separated)'
    end

  end

  included do

    swagger_controller 'Photos', 'Photos CRUD'

    # GET api/v1/photos.json
    swagger_api :index do |api|
      summary 'Fetches all Photos'
      notes 'This lists all Photos availables'
      API::V1::BaseController::index_common_params(api)
      response :ok
      response :requested_range_not_satisfiable
    end

    # GET api/v1/photos/1.json
    swagger_api :show do
      summary 'Fetches a single Photo'
      param :path, :id, :integer, :required, 'Photo Id'
      response :ok
      response :not_found
    end

    # POST api/v1/photos.json
    swagger_api :create do |api|
      summary 'Creates a new Photo'
      API::V1::PhotosController::add_common_params(api)
      response :created
      response :unprocessable_entity
    end

    # PATCH/PUT api/v1/photos/1.json
    swagger_api :update do |api|
      summary 'Updates an existing Photo'
      param :path, :id, :integer, :required, 'Photo Id'
      API::V1::PhotosController::add_common_params(api,:update)
      response :no_content
      response :not_found
      response :unprocessable_entity
    end

    # DELETE api/v1/photos/1.json
    swagger_api :destroy do
      summary 'Deletes an existing Photo'
      param :path, :id, :integer, :required, 'Photo Id'
      response :no_content
      response :unauthorized
      response :not_found
    end

  end

end