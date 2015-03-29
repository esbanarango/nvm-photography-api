class ApplicationController < ActionController::API
  include Swagger::Docs::ImpotentMethods

  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::ImplicitRender
  include ActsAsApi::Rendering

  self.responder = ActsAsApi::Responder
  respond_to :json
end
