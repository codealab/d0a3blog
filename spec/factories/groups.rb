FactoryGirl.define do

  factory :group do
    name "Primer Clase"
    cost "280"
    user { FactoryGirl.create(:user) }
    # init_date "10/01/2014"
    init_date Date.today.to_date
    # finish_date "20/03/2014"
    finish_date Date.today.to_date+10.weeks
    min_age 0
    max_age 120
    location "Aula uno"
  end

end