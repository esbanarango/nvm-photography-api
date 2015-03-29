class API::V1::BaseController < ApplicationController

  # Documentation
  include Documentation::API::V1::BaseControllerDoc

  before_filter :authenticate_user_from_token!

  protected

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|

      user_email = options[:user_email].presence
      user       = user_email && User.find_by(email: user_email)
      session    = token && user && user.sessions.find_by(authentication_token: token)

      if session && session.active?
        sign_in user, store: false
      end
    end
  end
end