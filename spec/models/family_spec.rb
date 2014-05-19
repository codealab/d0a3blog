# encoding: UTF-8
require 'spec_helper'

describe Family do
	before do
		@family = Family.new( name: "Perez Lopez" )
	end

	subject { @family }

	it { should respond_to(:name) }
	it { should respond_to(:status) }
	it { should respond_to(:family_relations) }
	it { should respond_to(:family_members) }


	# relations
	it { should respond_to(:address) }

	it { should respond_to(:responsible) }
	it { should respond_to(:family_relations) }
	it { should respond_to(:family_members) }
	it { should respond_to(:spots) }
	it { should respond_to(:payments) }
	it { should respond_to(:observations) }

	it { should be_valid }

	describe "when name is not present" do
		before { @family.name = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @family.name = "a" * 61 }
		it { should_not be_valid }
	end


	describe "when name name is already taken" do
		before do
			family_with_same_name = @family.dup
			family_with_same_name.name = @family.name.upcase
			family_with_same_name.save
		end

		it { should_not be_valid }
	end
end

# Checks that Factory Girl works
describe Family do
 
		subject {create(:family)}

		its(:name) { should include("family") }
		its(:status) { should be_true }
		its(:observations) { should == "Esta es una observación de la Familia Perez Lopez" }
end