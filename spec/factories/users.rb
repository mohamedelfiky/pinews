FactoryGirl.define do
  factory :user do
    sequence(:name) { Faker::Internet.user_name }
    sequence(:nickname) { Faker::Name.name }
    sequence(:email) { Faker::Internet.email }
    sequence(:password) { Faker::Internet.password }

    confirmed_at Time.zone.today

    role_id nil

    trait :admin do
      role_id { (Role.find_by_name('Admin') || create(:role, :admin)).id }
    end

    trait :author do
      role_id { (Role.find_by_name('Author') || create(:role)).id }
    end
  end
end
