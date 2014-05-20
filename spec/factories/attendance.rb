FactoryGirl.define do
	
	factory :attendance do
		spot { create(:spot) }
		lecture { create(:lecture) }
		observation "Lorem observation"
	end

end