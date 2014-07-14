# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program do
  	name 'Un Programa'
    min_age 0
    max_age 120
    number_of_lessons 30
	description 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.'
  end
end	