# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :foundation do
    name "MyString"
    timezone "MyString"
    quota_per_group 1
    error_range 1
  end
end
