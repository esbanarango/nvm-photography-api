if  Rails.env =~ /development/
  begin
    # Get authorization info
    admin = CreateAdminService.new.call
    session = admin.sessions.active.first
    if !session || !session.active?
      session = admin.sessions.create!
    end

    # Config Swagger
    GrapeSwaggerRails.options.url      = '/apidocs/api-docs.json'
    GrapeSwaggerRails.options.app_url  = 'http://lvh.me:3000'
    GrapeSwaggerRails.options.app_name = 'NVM Photography API'
    GrapeSwaggerRails.options.headers['Authorization'] = "Token token=#{session.authentication_token}, user_email=#{admin.email}"
  rescue
  end
end