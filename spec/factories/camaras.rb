FactoryGirl.define do
  factory :camara do
    model { generate(:unique_name) }
  end

end
