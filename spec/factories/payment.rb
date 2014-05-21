FactoryGirl.define do
  factory :payment do
    amount "999"
    date Date.today.to_date
    spot
    scholarship false
  end
end