module ControllerMacros

  # Inspired by https://github.com/thoughtbot/factory_girl/issues/359#issuecomment-21418209
  def attributes_with_foreign_keys_for(*args)
    attributes = FactoryGirl.build(*args).attributes.merge(attributes_for(*args))
    f = attributes.delete_if do |k, v|
      ["id", "type", "created_at", "updated_at", "reset_password_token", "last_sign_in_at",
      	"reset_password_sent_at","remember_created_at","sign_in_count","current_sign_in_at",
      	"current_sign_in_ip","last_sign_in_ip"].member?(k)
    end
    if f.has_key?("encrypted_password")
      f.delete "encrypted_password"
    	f["password"] = 'passwordd'
    	f["password_confirmation"] = 'passwordd'
    end
    f
  end
end

RSpec.configure do |config|
  config.include(ControllerMacros, type: :controller)
end
