require 'rails_helper'

FactoryGirl.define do
  factory :photo do
    title Faker::Name.title
    image Faker::Avatar.image
    association :article, factory: :article
  end
end
