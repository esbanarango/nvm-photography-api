# == Schema Information
#
# Table name: photos
#
#  id                      :integer          not null, primary key
#  camara_id               :integer
#  description             :text
#  aperture                :string
#  exposure                :string
#  iso                     :integer
#  shutter_speed           :string
#  color_space             :string
#  focal_length            :integer
#  took_at                 :datetime
#  settings                :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  attachment_file_name    :string
#  attachment_content_type :string
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#
# Indexes
#
#  index_photos_on_camara_id  (camara_id)
#

class Photo < ActiveRecord::Base

  include Responses::Photo

  acts_as_taggable

	# Paperclip
  has_attached_file :attachment,
    :styles => {
      :thumb => "100x100",
      :small  => "250x250",
      :medium => "300x300" }

  # Validations
  validates :description, presence: true

	# Relations
  belongs_to :camara
end
