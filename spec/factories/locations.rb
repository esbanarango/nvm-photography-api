require 'faker'

FactoryGirl.define do
  factory :location do
    country { Faker::Address.country }
		country_code { Faker::Address.country_code }
		city { generate(:unique_name) }
  end
end
