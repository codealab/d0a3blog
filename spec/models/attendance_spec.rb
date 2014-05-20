require 'spec_helper'

describe Attendance do

	let(:lecture) { FactoryGirl.create(:lecture) }
	let(:spot) { FactoryGirl.create(:spot) }

	before do
		@attendance = Attendance.new( spot_id: spot.id, lecture_id: lecture.id, observation: "Lorem observation" )
	end

	subject { @attendance }

	it { should respond_to(:spot_id) }
	it { should respond_to(:lecture_id) }
	it { should respond_to(:observation) }

	it { should be_valid }

	describe "when spot_id is not present" do
		before { @attendance.spot_id = " " }
		it { should_not be_valid }
	end

	describe "when lecture_id is not present" do
		before { @attendance.lecture_id = " " }
		it { should_not be_valid }
	end

end

describe Attendance do
	subject { create(:attendance) }

	its(:observation) { should == "Lorem observation" }

end