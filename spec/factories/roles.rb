require 'rails_helper'

FactoryGirl.define do
  factory :role do
    name 'Author'

    trait :admin do
      name 'Admin'
    end
  end
end
