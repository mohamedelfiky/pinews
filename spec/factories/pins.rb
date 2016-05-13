require 'rails_helper'

FactoryGirl.define do
  factory :pin do
    association :article, factory: :article
    association :user, factory: [:user, :author]
  end
end
