# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  camara_id          :integer
#  description        :text
#  aperture           :string
#  exposure           :string
#  iso                :integer
#  shutter_speed      :string
#  color_space        :string
#  focal_length       :integer
#  took_at            :datetime
#  settings           :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  location_id        :integer
#
# Indexes
#
#  index_photos_on_camara_id    (camara_id)
#  index_photos_on_location_id  (location_id)
#

class Photo < ActiveRecord::Base

  include Responses::Photo

  acts_as_taggable

	# Paperclip
  has_attached_file :image, styles: { small: '250x250', medium: '300x300' }

  # Validations
  validates :description, :image, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage/

	# Relations
  belongs_to :camara
  belongs_to :location, counter_cache: true
end
