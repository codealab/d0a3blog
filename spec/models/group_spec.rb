require 'spec_helper'

describe Group do
	
	let(:user) { FactoryGirl.create(:user) }

	before do
		@group = Group.new( name: "Primer Curso", user_id: user.id, cost: 123, init_date: '12/01/2014', finish_date: '12/02/2014', min_age: 3, max_age: 120, location: 'Aula uno' )
	end

	subject { @group }

	it { should respond_to(:name) }
	it { should respond_to(:user_id) }
	it { should respond_to(:cost) }
	it { should respond_to(:init_date) }
	it { should respond_to(:finish_date) }
	it { should respond_to(:location) }
	it { should respond_to(:min_age) }
	it { should respond_to(:max_age) }
	it { should respond_to(:spots) }
	it { should respond_to(:lectures) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @group.user_id = nil }
		it { should_not be_valid }
	end

	describe "when invalid atribute" do
		before do
			@group.name = " "
			@group.cost = "-10"
			@group.init_date = " "
			@group.finish_date = " "
			@group.min_age = "-10"
			@group.max_age = " 300"
			@group.location = " "
		end

		it { should have(1).error_on(:name) }
		it { should have(1).error_on(:cost) }
		it { should have(1).error_on(:init_date) }
		it { should have(1).error_on(:finish_date) }
		it { should have(1).error_on(:min_age) }
		it { should have(1).error_on(:max_age) }
		it { should have(1).error_on(:location) }
	end

	describe "when name is too long" do
		before { @group.name = "a" * 61 }
		it { should_not be_valid }
	end

end
# Checks that Factory Girl works
describe Group do
 
	subject { create(:group) }

	its(:name) { should == "Primer Clase" }
	its(:cost) { should ==  280 }
	its(:min_age) { should ==  0 }
	its(:max_age) { should ==  120 }
	its(:location) { should ==  "Aula uno" }
end