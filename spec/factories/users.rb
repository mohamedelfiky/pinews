FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| Faker::Internet.user_name }
    sequence(:nickname) { |n| Faker::Name.name }
    sequence(:email) { |n| Faker::Internet.email }
    sequence(:password) { |n| Faker::Internet.password }

    confirmed_at Date.today

    trait :guest do
      role_id nil
    end

    trait :admin do
      role_id Role.find_by_name('Admin').id
    end

    trait :normal_user do
      role_id Role.find_by_name('User').id
    end

  end
end
