# encoding: UTF-8
require 'spec_helper'

describe 'Exercise' do
	before do
		@exercise = Exercise.new(
			name: 'Ejercicio Uno',
			min_age:0, max_age: 48,
			objective: 'Este es un objetivo en ejercicio',
			description: 'Este es la descripción del ejercicio',
			material: 'Pelota, aros, rodillo',
			music: 'Canción #1, Canción #2, Canción #3' )
	end

	subject { @exercise }

	it { should respond_to(:name) }
	it { should respond_to(:areas) }
	it { should respond_to(:min_age) }
	it { should respond_to(:max_age) }
	it { should respond_to(:objective) }
	it { should respond_to(:description) }
	it { should respond_to(:material) }
	it { should respond_to(:music) }
	it { should respond_to(:lectures) }
	it { should respond_to(:plans) }

	it { should be_valid }

	describe "when invalid atribute" do
		before do
			@exercise.name = " "
			@exercise.min_age = " "
			@exercise.max_age = " "
			@exercise.objective = " "
			@exercise.description = " "
		end

		it { should have(1).error_on(:name) }
		it { should have(1).error_on(:min_age) }
		it { should have(1).error_on(:max_age) }
		it { should have(1).error_on(:objective) }
		it { should have(1).error_on(:description) }

	end

	describe "has relation with classes" do
		let(:lecture) { create(:lecture) }
		let(:exercise) { lecture.exercises.create(
			name:'Ejercicio',
			min_age:0, max_age: 48,
			objective: 'Este es un objetivo en ejercicio',
			description: 'Este es la descripción del ejercicio',
			material: 'Pelota, aros, rodillo',
			music: 'Canción #1, Canción #2, Canción #3 ' ) }

	end

end

# Checks that Factory Girl works
# describe Exercise do
 
#		subject {create(:exercise)}

#		its(:name) { should include("Exercise") }
#		its(:status) { should be_true }
#		its(:observations) { should == "Esta es una observación de la Familia Perez Lopez" }
#end