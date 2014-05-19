require 'spec_helper'

describe Spot do

	let(:child) { FactoryGirl.create(:person) }
	let(:tutor) { FactoryGirl.create(:person) }
	let(:group) { FactoryGirl.create(:group) }

	before do
		@spot = Spot.new( child_id: child.id, tutor_id: tutor.id, group_id: group.id )
	end

	subject { @spot }

	it { should respond_to(:child_id) }
	it { should respond_to(:group_id) }
	it { should respond_to(:tutor_id) }
	it { should respond_to(:balance) }
	it { should respond_to(:payments) }
	it { should respond_to(:lectures) }
	it { should respond_to(:attendances) }

	it { should be_valid }

	describe "when attribute is not present" do

		before do
			@spot.child_id = " "
			@spot.tutor_id = " "
			@spot.group_id = " "
		end

		it { should have(1).error_on(:child_id) }
		# it { should have(1).error_on(:tutor_id) } #Ya no está validado, debe de ir en la test?
		it { should have(1).error_on(:group_id) }

	end

end