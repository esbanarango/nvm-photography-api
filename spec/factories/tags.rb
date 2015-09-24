FactoryGirl.define do
  factory :tag do
    name { generate(:unique_name) }
  end
end
