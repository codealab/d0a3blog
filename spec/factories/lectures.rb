FactoryGirl.define do
  factory :lecture do
  	group
    observation "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."
    # date "01/02/2014 10:30"
    date DateTime.now+1.hour
    # sequence(:date)  { |n| DateTime.now+n.day }
  end
end