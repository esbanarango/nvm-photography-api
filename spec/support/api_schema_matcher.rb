RSpec::Matchers.define :match_response_schema do |schema|
  match do |response|
    schema_directory = "#{Dir.pwd}/spec/support/schemas/api"
    schema_path = "#{schema_directory}/#{schema}.json"
    json_on_response = response.try(:body) || response
    JSON::Validator.validate!(schema_path, json_on_response, strict: true)
  end
end