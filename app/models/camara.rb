# == Schema Information
#
# Table name: camaras
#
#  id         :integer          not null, primary key
#  model      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Camara < ActiveRecord::Base

  # Validations
  validates :model, presence: true, uniqueness: true

  # Relations
  has_many :photos

end
