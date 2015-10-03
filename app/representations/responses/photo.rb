module Responses::Photo
  extend ActiveSupport::Concern
  included do

    acts_as_api

    api_accessible :default do |t|
      t.add :id
      t.add :camara_id
      t.add :description
      t.add :aperture
      t.add :exposure
      t.add :iso
      t.add :shutter_speed
      t.add :color_space
      t.add :focal_length
      t.add :took_at
      t.add :settings
      t.add :tag_list
      t.add -> (photo) { photo.image.file? ? photo.image.url(:original, false) : '' }, as: :image_url
      t.add :created_at
      t.add :updated_at
    end

  end
end