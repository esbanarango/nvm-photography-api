class API::V1::PhotosController < API::V1::BaseController

  include API::V1::CommonActions
  # Documentation
  include Documentation::API::V1::PhotosControllerDoc

  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_photo, only: [:show, :update, :destroy]

  # GET api/v1/photos.json
  def index
    common_index Photo
  end

  # GET api/v1/photos/1.json
  def show
    respond_with :api, :v1, @photo, api_template: :default
  end

  # POST api/v1/photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.save
    respond_with :api, :v1, @photo, api_template: :default
  end

  # PATCH/PUT api/v1/photos/1.json
  def update
    @photo.update(photo_params)
    respond_with :api, :v1, @photo, api_template: :default
  end

  # DELETE api/v1/photos/1.json
  def destroy
    @photo.destroy
    respond_with :api, :v1, head: :no_content
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def photo_params
    params.require(:photo).permit(:image, :camara_id, :description, :aperture, :exposure,
      :iso, :shutter_speed, :color_space, :focal_length, :took_at, :settings, tag_list: [])
  end

end