# encoding: UTF-8
require 'spec_helper'

describe 'Exercise pages' do
	
	subject { page }

	let(:user) { create(:user, :is_admin) }
	let(:exercise) { create(:exercise) }
	let(:lecture) { create(:lecture) }
	let(:group) { create(:group) }
	let(:area) { create(:area) }

  	before { sign_in user }

	describe 'Index Exercises' do
		before do
	  		5.times { create(:exercise) }
			visit group_lecture_exercises_path(group,lecture)
		end

		describe 'Should render exercise list' do
			it "should list each exercise" do
				expect(page).to have_button("Nuevo Ejercicio")
				expect(page).to have_button("Regresar a Grupo")
			end
		end
	end

	describe 'New exercise' do
		before { visit new_group_lecture_exercise_path(group,lecture) }
		it { should have_title('Nuevo Ejercicio') }
		it { should have_button("Regresar a Ejercicios") }
		it { should have_link("Regresar a Ejercicios", href: group_lecture_exercises_path(group,lecture) ) }
		
		describe "with invalid information" do
			before { click_button("Guardar") }
			it { should have_content("errores") }
		end

		describe "with valid information" do
			before do
				fill_in "exercise[name]",	:with => "Ejercicio 1"
				fill_in "exercise[min_age]",	:with => "0"
				fill_in "exercise[max_age]",	:with => "48"
				fill_in "exercise[objective]",	:with => "Este es un objetivo en ejercicio"
				fill_in "exercise[description]",:with => "Este es la descripción del ejercicio"
				fill_in "exercise[material]",	:with => "Pelota, aros, rodillo"
				fill_in "exercise[music]",	:with => "Canción #1, Canción #2, Canción #3"
				# select("#{area.name}", :from => 'exercise[area]')
				# check "area_" #click en check algún area ???
				expect { click_button "Guardar" }.to change(Exercise, :count).by(0)
			end

			it { should have_content("El ejercicio debe contener al menos un área") }

		end
	end

	describe 'Show exercise' do
		before { visit group_lecture_exercise_path(group,lecture,exercise) }

		it { should have_content(exercise.material) }
		it { should have_title(exercise.name.capitalize) }
		it { should have_content(exercise.objective) }
		it { should have_content(exercise.description) }
		it { should have_content(exercise.material) }
		it { should have_content(exercise.music) }
		it { should have_button("Regresar a Ejercicios") }
	end

	describe 'Edit exercise' do
		before { visit edit_group_lecture_exercise_path(group,lecture,exercise) }

		it { should have_title("#{exercise.name.capitalize}") }
		it { should have_button("Regresar a Ejercicios") }

		describe "with invalid information" do
			before do
				fill_in "exercise[min_age]", :with => " "
				click_button "Guardar"
			end
			it { should have_content("La forma contiene 1 error") }
		end

		describe "with valid information" do
			before do
				fill_in "exercise[min_age]",	:with => "10"
				fill_in "exercise[max_age]",	:with => "36"
				fill_in "exercise[objective]",	:with => "Este es otro objetivo en ejercicio"
				fill_in "exercise[description]",	:with => "Este es otra descripción del ejercicio"
				fill_in "exercise[material]",	:with => "Pelota, rodillo, Pablo"
				fill_in "exercise[music]",	:with => "Canción #3, Canción #4, Canción #5"
				
				click_button "Guardar"

			end

			it { should have_title("Grupo ") }
			it { should have_content("Actualización exitosa") }

		end
	end

	describe 'Destroy exercise' do
		
		before { visit group_lecture_exercise_path(group,lecture,exercise) }
		
		it { should have_button('Borrar Ejercicio') }
		it { should have_link('Borrar Ejercicio', href: group_lecture_exercise_path(group,lecture,exercise) ) }
		
		describe "should delete an exercise" do

			before do
				expect { click_link "Borrar Ejercicio" }.to change(Exercise, :count).by(-1)
			end

			it { should have_title('D0A3') }
			it { should have_content("Ejercicio borrado") }

		end

	end

end