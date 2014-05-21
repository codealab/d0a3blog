FactoryGirl.define do
	
	factory :spot do
		child { create(:person, :children) }
		tutor { create(:person) }
		group # { create(:group) }
	end

end