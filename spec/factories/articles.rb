require 'rails_helper'

FactoryGirl.define do
  factory :article do
    title Faker::Name.title
    description Faker::Hipster.paragraph(2)
    image Faker::Avatar.image
    author_id { FactoryGirl.create(:user, :admin).id }
  end
end
