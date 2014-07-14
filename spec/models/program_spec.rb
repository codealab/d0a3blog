require 'spec_helper'

describe "Program" do

	before do
		@program = Program.new( min_age:0, max_age:120, name: "Programa Nuevo", number_of_lessons:30 )
	end

	subject { @program }

	it { should respond_to(:min_age) }
	it { should respond_to(:max_age) }
	it { should respond_to(:name) }
	it { should respond_to(:number_of_lessons) }
	it { should respond_to(:description) }
	it { should respond_to(:lessons) }
	it { should respond_to(:exercises) }

	it { should be_valid }

	describe "when invalid attribute" do

		before do
			@program.min_age = " "
			@program.max_age = " "
			@program.name = " "
			@program.number_of_lessons = " "
			end

		it { should have(1).error_on(:min_age) }
		it { should have(1).error_on(:max_age) }
		it { should have(1).error_on(:name) }
		it { should have(1).error_on(:number_of_lessons) }

	end

end