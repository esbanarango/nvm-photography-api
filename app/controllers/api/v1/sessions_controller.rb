class API::V1::SessionsController < Devise::SessionsController

  def create
    resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
    sign_in_and_redirect(resource_name, resource)
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    @session = resource.sessions.create!
    data = {
      token: @session.authentication_token,
      user_email: resource.email
    }
    render json: data, status: 200
  end

  def failure
    render json: {success: false, errors: ["Invalid email or password."]}, status: 401
  end

end