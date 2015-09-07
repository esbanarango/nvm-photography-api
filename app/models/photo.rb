# == Schema Information
#
# Table name: photos
#
#  id            :integer          not null, primary key
#  camara_id     :integer
#  description   :text
#  aperture      :string
#  exposure      :string
#  iso           :integer
#  shutter_speed :string
#  color_space   :string
#  focal_length  :integer
#  took_at       :datetime
#  settings      :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_photos_on_camara_id  (camara_id)
#

class Photo < ActiveRecord::Base

  # Validations
  validates :description, presence: true

	# Relations
  belongs_to :camara
end
