FactoryGirl.define do
  factory :user do
    sequence(:name) { Faker::Internet.user_name }
    sequence(:nickname) { Faker::Name.name }
    sequence(:email) { Faker::Internet.email }
    sequence(:password) { Faker::Internet.password }

    confirmed_at Time.zone.today

    trait :guest do
      role_id nil
    end

    trait :admin do
      role_id Role.find_by_name('Admin').id
    end

    trait :author do
      role_id Role.find_by_name('Author').id
    end
  end
end
