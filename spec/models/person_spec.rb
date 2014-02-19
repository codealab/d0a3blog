require 'spec_helper'

describe Person do

	before do
		@person = Person.new( name: "Fernando", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/1995", family_roll: "Hijo")
	end

	subject { @person }

	it { should respond_to(:name) }
	it { should respond_to(:first_last_name) }
	it { should respond_to(:second_last_name) }
	it { should respond_to(:sex) }
	it { should respond_to(:dob) }
	it { should respond_to(:family_roll) }
	it { should respond_to(:family_relations) }
	it { should respond_to(:families) }


	it { should be_valid }

	it "returns a persons full name as a string" do
   expect(@person.full_name).to eq 'Fernando Garcia Lopez'
  end


	describe "when invalid atribute" do
		before do
			@person.name = " "
			@person.first_last_name = " "
			@person.second_last_name = " "
			@person.sex = " "
			@person.dob = " "
			@person.family_roll = " "
		end

		it { should have(1).error_on(:name) }
		it { should have(1).error_on(:first_last_name) }
		it { should have(1).error_on(:second_last_name) }
		it { should have(2).error_on(:sex) }
		it { should have(1).error_on(:dob) }
		it { should have(1).error_on(:family_roll) }
	end

	
	describe "when atribute is too long" do
		before do
			@person.name = "a" * 51 
			@person.first_last_name = "a" * 51 
			@person.second_last_name = "a" * 51 
			@person.family_roll = "a" * 51 
		end

		it { should have(1).error_on(:name) }
		it { should have(1).error_on(:first_last_name) }
		it { should have(1).error_on(:second_last_name) }
		it { should have(1).error_on(:family_roll) }
	end


	describe "when dob is after than today" do
		before do
			@person.dob = Date.today + 10.days
		end

		it { should have(1).error_on(:dob) }
	end

	describe "when complete name is already taken" do
		before do
			person_with_same_complete_name = @person.dup
			person_with_same_complete_name.name = @person.name.downcase
			person_with_same_complete_name.first_last_name = @person.first_last_name.upcase
			person_with_same_complete_name.second_last_name = @person.second_last_name.titleize
			person_with_same_complete_name.save
		end

		it { should_not be_valid }
	end

end


# Checks that Factory Girl works
describe Person do
	subject {build(:person)}

		its(:name) { should == "Fernando" }
end