FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@test.com" }
  sequence(:unique_name) { |n| "name#{n}" }
end