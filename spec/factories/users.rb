FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    trait :is_admin do
        admin true
    end
    trait :is_facilitator do
        facilitator true
    end
  end
end