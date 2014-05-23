require 'spec_helper'

describe Lecture do

	let(:group) { FactoryGirl.create(:group) }

	before do
		@class = Lecture.new( :group_id => group.id, :date => DateTime.now+1.day, :observation => 'Lorem ipsum dolor sit amet')
	end

	subject { @class }

	it { should respond_to(:group_id) }
	it { should respond_to(:date) }
	it { should respond_to(:observation) }
	it { should respond_to(:exercises) }
	it { should respond_to(:plans) }
	it { should respond_to(:attendances) }

	it { should be_valid }

	describe "when date is not present" do
		before { @class.date = " " }
		it { should_not be_valid }
	end

	describe "when group_id is not present" do
		before { @class.group_id = " " }
		it { should_not be_valid }
	end

end

describe Lecture do
	
	subject { create(:lecture) }

	# its(:date) { should == "01/02/2014 10:30" }
	its(:observation) { should == "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam." }

end