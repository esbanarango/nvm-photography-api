# == Schema Information
#
# Table name: locations
#
#  id           :integer          not null, primary key
#  country      :string
#  country_code :string
#  city         :string
#  photos_count :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Location < ActiveRecord::Base

  # Relations
  has_many :photos

  # Validations
  validates :country, :city, presence: true
  validates :city, uniqueness: { scope: :country }

end
