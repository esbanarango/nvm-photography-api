require 'faker'

FactoryGirl.define do
  factory :user do

    email           { generate(:email) }
    password        'password'
    first_name      { Faker::Name.first_name }
    last_name       { Faker::Name.last_name }

    factory :admin do
      role 'admin'
    end

    factory :invalid_user do
      email nil
    end

  end
end
