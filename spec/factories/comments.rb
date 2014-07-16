# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    name "MyString"
    email "MyString"
    website "MyString"
    text "MyText"
    post_id 1
  end
end
