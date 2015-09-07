source 'https://rubygems.org'
ruby ENV['CUSTOM_RUBY_VERSION'] || '2.2.1'
gem 'rails', '4.2.4'
gem 'spring',        group: :development
gem 'responders', '~> 2.1.0'
gem 'devise'
gem 'pg'
gem 'sendgrid'
gem 'thin'
gem 'paperclip', '~> 4.2.1'
gem 'aws-sdk', '~> 2.0.32'
gem 'rack-cors', require: 'rack/cors'
gem 'rails-api', '~> 0.4.0'
gem 'acts_as_api', '~> 0.4.2'
gem 'kaminari', '~> 0.16.3'
gem 'swagger-docs'
gem 'grape-swagger-rails'
gem 'newrelic_rpm'
group :production, :staging do
  gem 'puma'
  gem 'rails_12factor'
end
group :development, :staging do
  gem 'bullet'
end
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'capistrano', '~> 3.0.1'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rails-console'
  gem 'capistrano-rvm', '~> 0.1.1'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring-commands-rspec'
  gem 'annotate', '~> 2.6.5'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem 'json_spec', '~> 1.1.4'
  gem 'dotenv-rails'
end
group :test do
  gem 'json-schema'
  gem 'database_cleaner'
  gem 'codeclimate-test-reporter', require: nil
  gem 'shoulda-callback-matchers', '~> 1.1.2'
end
