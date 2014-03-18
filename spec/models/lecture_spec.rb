require 'spec_helper'

describe Lecture do

	let(:group) { FactoryGirl.create(:group) }

	before do
		@class = Lecture.new( :group_id => group.id, :date => '12/01/2014 10:30', :observation => 'Lorem ipsum dolor sit amet')
	end

	subject { @class }

	it { should respond_to(:group_id) }
	it { should respond_to(:date) }
	it { should respond_to(:observation) }
	it { should respond_to(:exercises) }
	it { should respond_to(:plans) }

	it { should be_valid }

	describe "when date is not present" do
		before { @class.date = " " }
		it { should_not be_valid }
	end

	# describe "when group_id is not present" do
	# 	before { @class.group_id = nil }
	# 	it { should_not be_valid }
	# end

end