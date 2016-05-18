require 'rails_helper'

FactoryGirl.define do
  factory :pin do
    association :article, factory: :article
    association :user, factory: %i(user author)
  end
end
