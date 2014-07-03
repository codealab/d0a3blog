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
				expect(page).to have_button("Nueva Actividad")
				expect(page).to have_button("Regresar a Grupo")
			end
		end
	end

	describe 'New exercise' do
		before { visit new_group_lecture_exercise_path(group,lecture) }
		it { should have_title('Nueva Actividad') }
		it { should have_button("Regresar a Actividades") }
		# it { should have_link("Regresar a Actividades", href: :back ) }
		
		describe "with invalid information" do
			before { click_button("Crear Actividad") }
			it { should have_content("errores") }
		end

		describe "with valid information" do
			before do
				fill_in "exercise[name]",	:with => "Actividad 1"
				fill_in "exercise[min_age]",	:with => "0"
				fill_in "exercise[max_age]",	:with => "48"
				fill_in "exercise[objective]",	:with => "Este es un objetivo en actividad"
				fill_in "exercise[description]",:with => "Este es la descripción del actividad"
				fill_in "exercise[material]",	:with => "Pelota, aros, rodillo"
				fill_in "exercise[music]",	:with => "Canción #1, Canción #2, Canción #3"
				# select("#{area.name}", :from => 'exercise[area]')
				# check "area_" #click en check algún area ???
				expect { click_button "Crear Actividad" }.to change(Exercise, :count).by(0)
			end

			it { should have_content("La actividad debe contener al menos un área") }

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
		it { should have_button("Regresar a Actividades") }
	end

	describe 'Edit exercise' do
		before { visit edit_group_lecture_exercise_path(group,lecture,exercise) }

		it { should have_title("#{exercise.name.capitalize}") }
		it { should have_button("Regresar a Actividades") }

		describe "with invalid information" do
			before do
				fill_in "exercise[min_age]", :with => " "
				click_button "Guardar Actividad"
			end
			it { should have_content("La forma contiene 1 error") }
		end

		describe "with valid information" do
			before do
				fill_in "exercise[min_age]",	:with => "10"
				fill_in "exercise[max_age]",	:with => "36"
				fill_in "exercise[objective]",	:with => "Este es otro objetivo en actividad"
				fill_in "exercise[description]",	:with => "Este es otra descripción del actividad"
				fill_in "exercise[material]",	:with => "Pelota, rodillo, Pablo"
				fill_in "exercise[music]",	:with => "Canción #3, Canción #4, Canción #5"
				
				click_button "Guardar Actividad"

			end

			it { should have_title("Grupo ") }
			it { should have_content("Actualización exitosa") }

		end
	end

	describe 'Destroy exercise' do
		
		before { visit group_lecture_exercise_path(group,lecture,exercise) }
		
		it { should have_button('Borrar Actividad') }
		it { should have_link('Borrar Actividad', href: group_lecture_exercise_path(group,lecture,exercise) ) }
		
		describe "should delete an exercise" do

			before do
				expect { click_link "Borrar Actividad" }.to change(Exercise, :count).by(-1)
			end

			# it { should have_title('D0A3') }
			it { should have_content("Actividad borrada") }

		end

	end

end