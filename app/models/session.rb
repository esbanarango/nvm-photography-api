# == Schema Information
#
# Table name: sessions
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  authentication_token :string
#  expires_at           :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_sessions_on_user_id  (user_id)
#

class Session < ActiveRecord::Base

  # Relations
  belongs_to :user

  # Validations
  validates :user, presence: true
  validates_uniqueness_of :user, scope: [:authentication_token]

  # Callbacks
  before_create :generate_authentication_token
  before_create :set_expires_at
  after_create  :expire_old!

  # Scopes
  scope :active, lambda { where('? < expires_at', Time.now) }
  scope :inactive, lambda { where('? >= expires_at', Time.now) }

  def expire_old!
    user.sessions.inactive.destroy_all
  end

  def active?
    Time.now < expires_at
  end

  private

  def set_expires_at
    self.expires_at ||= Time.now + 30.days
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break self.authentication_token = token unless Session.where(authentication_token: token, user_id: user.id).first
    end
  end

end
