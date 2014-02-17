# encoding: UTF-8
require 'spec_helper'

describe 'Exercise pages' do
	subject { page }

	let(:user) { create(:user, :is_admin) }
	let(:exercise) { create(:exercise) }

  	before do
	  	sign_in user
	end

	describe 'Index Exercises' do
		before do
	  	10.times { create(:exercise) }
			visit exercises_path
		end

		it { should have_title('Todos los Ejercicios') }

		describe 'Should render exercise list' do
			it "should list each exercise" do
				Exercise.all.each do |exercise|
					expect(page).to have_content(exercise.objective)
					expect(page).to have_link("Detalle", href: exercise_path(exercise))					
				end
			end
		end
	end

	describe 'New exercise' do
		before { visit new_exercise_path }
		it { should have_title('Nuevo Ejercicio') }
		it { should have_button("Regresar a Ejercicios") }
		it { should have_link("Regresar a Ejercicios", href: exercises_path ) }
		
		describe "with invalid information" do
			before { click_button("Guardar") }
			it { should have_content("5 errors") }
		end

		describe "with valid information" do
			before do
				select 'Lenguaje', from: "exercise_area"
				fill_in "exercise[min_age]",	:with => "0"
				fill_in "exercise[max_age]",	:with => "48"
				fill_in "exercise[objective]",	:with => "Este es un objetivo en ejercicio"
				fill_in "exercise[description]",	:with => "Este es la descripción del ejercicio"
				fill_in "exercise[material]",	:with => "Pelota, aros, rodillo"
				fill_in "exercise[music]",	:with => "Canción #1, Canción #2, Canción #3"
				
				expect { click_button "Guardar" }.to change(Exercise, :count).by(1)

			end

			it { should have_title("Todos los Ejercicios") }
			it { should have_content("Ejercicio creado exitosamente") }

		end
	end

	describe 'Show exercise' do
		before { visit exercise_path(exercise) }

		it { should have_content(exercise.material) }
		it { should have_title(exercise.full_name) }
		it { should have_content(exercise.objective) }
		it { should have_content(exercise.description) }
		it { should have_content(exercise.material) }
		it { should have_content(exercise.music) }
		it { should have_button("Regresar a Ejercicios") }
	end

	describe 'Edit exercise' do
		before { visit edit_exercise_path(exercise) }

		it { should have_title("Editar #{exercise.full_name}") }
		it { should have_button("Regresar a Ejercicios") }

		describe "with invalid information" do
			before do
				fill_in "exercise[min_age]", :with => " "
				select 'Lenguaje', from: "exercise_area"
				click_button "Guardar"
			end
			it { should have_content("The form contains 1 error") }
		end

		describe "with valid information" do
			before do
				select 'Motricidad Gruesa', from: "exercise_area"
				fill_in "exercise[min_age]",	:with => "10"
				fill_in "exercise[max_age]",	:with => "36"
				fill_in "exercise[objective]",	:with => "Este es otro objetivo en ejercicio"
				fill_in "exercise[description]",	:with => "Este es otra descripción del ejercicio"
				fill_in "exercise[material]",	:with => "Pelota, rodillo, Pablo"
				fill_in "exercise[music]",	:with => "Canción #3, Canción #4, Canción #5"
				
				click_button "Guardar"

			end

			it { should have_title("Todos los Ejercicios") }
			it { should have_content("Actualización exitosa") }

		end
	end

	describe 'Destroy exercise' do
		
		before { visit exercise_path(exercise) }
		
		it { should have_button('Borrar Ejercicio') }
		it { should have_link('Borrar Ejercicio', href: exercise_path(exercise) ) }
		
		describe "should delete an exercise" do

			before do
				expect { click_link "Borrar Ejercicio" }.to change(Exercise, :count).by(-1)
			end

			it { should have_title('Todos los Ejercicios') }
			it { should have_content("Ejercicio borrado") }

		end

	end

end
