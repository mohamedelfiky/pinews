require 'rails_helper'

FactoryGirl.define do
  factory :photo do
    title Faker::Name.title
    image { fixture_file_upload(FIXTURE_IMAGE, 'image/png')}
    association :article, factory: :article
  end
end
