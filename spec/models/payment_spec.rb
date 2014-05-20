require 'spec_helper'

describe Payment do

	let(:spot) { FactoryGirl.create(:spot) }
	let(:group) { FactoryGirl.create(:group) }

	before do
		@payment = Payment.new( amount: "999", :spot_id => spot.id, group_id: group.id, date: Date.today, scholarship: false, clarification: "Lorem Ipsum" )
	end

	subject { @payment }

	it { should respond_to(:amount) }
	it { should respond_to(:date) }
	it { should respond_to(:spot_id) }
	it { should respond_to(:group_id) }
	it { should respond_to(:scholarship) }
	it { should respond_to(:clarification) }

	it { should be_valid }

	describe "when amount is not valid" do
		before { @payment.amount = " " }
		it { should_not be_valid }
	end

	describe "when spot_id is not present" do
		before { @payment.spot_id = " " }
		it { should_not be_valid }
	end
	
	describe "when date is not valid" do
		before { @payment.date = " " }
		it { should_not be_valid }
	end

end

# describe Payment do
	
# 	subject { create(:payment) }

# 	its(:amount) { should == "999" }
# 	# its(:date) { should == "12/01/2014" } #.strftime('%d/%m/%Y')
# 	its(:scholarship) { should == false }

# end