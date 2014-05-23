# encoding: UTF-8
FactoryGirl.define do
  factory :exercise do
  	sequence(:name)  { |n| "Exercise#{n}" }
    sequence(:min_age) { |n| "#{n*10}"}
    sequence(:max_age) { |n| "#{(n*10)+9}"}
    objective 'Este es un objetivo en ejercicio'
	description 'Este es la descripción del ejercicio'
	material 'Pelota, aros, rodillo'
	music 'Canción #1, Canción #2, Canción #3'
  end
end