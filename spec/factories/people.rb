FactoryGirl.define do

  factory :person do
    name "Fernando"
    sequence(:first_last_name) { |n| "Garcia#{n}" }
    sequence(:second_last_name) { |n| "Hernandez#{n}" }
    sex "M"
    dob "20/01/1995"
    family_roll "Hijo"

    trait :children do
        dob "01/01/2014"
    	# dob { rand(4.years).ago }
        # families { create(:family, :responsible) }
    end

    # trait :family do
    #     families { FactoryGirl.create(:family, :responsible) }
    # end

  end

end

# FactoryGirl.define :person do |f|
#     f.name "Fernando"
#     f.sequence(:first_last_name) { |n| "Garcia#{n}" }
#     f.sequence(:second_last_name) { |n| "<Hernandez id="">n</Hernandez>" }
#     f.sex "M"
#     f.dob "20/01/1995"
#     f.family_roll "Hijo"
#     f.families { |a| a.association(:family) }

#     # trait :children do
#     #     dob "01/01/2014"
#     #     # dob { rand(4.years).ago }
#     #     # families { create(:family, :responsible) }
#     # end

#     # trait :family do
#     #     families { create(:family) }
#     # end

# end