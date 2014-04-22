# encoding: UTF-8
require 'spec_helper'

describe 'Lectures pages' do

	subject { page }

	let(:user) { create(:user, :is_admin, :is_instructor) }
	let(:group) { create(:group) }
	let(:lecture) { create( :lecture, group: group ) }

  	before do
		sign_in user
		5.times { create(:group) }
		visit groups_path
	end

	describe 'new lecture' do

		before { visit new_group_lecture_path(group) }

		describe 'Show create class information' do
			it { should have_title("Nueva Clase") }
			it { should have_link("Regresar a Grupo") }
			it { should have_button("Guardar") }
		end

		describe "with invalid information" do
			it "should not create a lecture" do
				expect { click_button "Guardar" }.not_to change(Lecture, :count)
			end
			describe "error messages" do
				before { click_button "Guardar" }
				it { should have_title('Nueva Clase') }
			end
		end

		describe "with valid information" do
			before do
				fill_in 'lecture[observation]', :with => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.'
				select '2014', from: 'lecture[date(1i)]'
				select 'Febrero', from: 'lecture[date(2i)]'
				select '12', from: 'lecture[date(3i)]'
				select '11', from: 'lecture[date(4i)]'
				select '30', from: 'lecture[date(5i)]'
				
				expect { click_button "Guardar" }.to change(Lecture, :count).by(1)
			end
			it { should have_selector("div.alert.alert-success") }
			it { should have_content('Clase creada exitosamente') }
		end

		describe "with date out of range" do
			before do
				fill_in 'lecture[observation]', :with => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.'
				select '2014', from: 'lecture[date(1i)]'
				select 'Marzo', from: 'lecture[date(2i)]'
				select '30', from: 'lecture[date(3i)]'
				select '12', from: 'lecture[date(4i)]'
				select '00', from: 'lecture[date(5i)]'
				
				expect { click_button "Guardar" }.not_to change(Lecture, :count)
			end
			it { should have_selector("div.alert.alert-danger") }
			it { should have_content('La fecha que seleccionaste está fuera de la duración del curso') }
		end

	end

	describe 'edit lecture' do
		
		before { visit edit_group_lecture_path(group, lecture) }

		it { should have_title('Editar Clase') }
		it { should have_button('Regresar a la Clase') }
		it { should have_button('Guardar') }
		it { should have_content('Fecha') }

		describe 'with valid information' do
			before do
				fill_in 'lecture[observation]', :with => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.'
				select '2014', from: 'lecture[date(1i)]'
				select 'Febrero', from: 'lecture[date(2i)]'
				select '24', from: 'lecture[date(3i)]'
				select '12', from: 'lecture[date(4i)]'
				select '00', from: 'lecture[date(5i)]'

				click_button "Guardar"
			end

			it { should have_selector("div.alert.alert-success") }
			it { should have_content("Actualización Exitosa") }
		end

		describe 'Destroy lecture' do
			before { visit edit_group_lecture_path(group, lecture) }

			describe 'Show class information' do
		
				it { should have_title('Editar Clase') }
				it { should have_button("Borrar Clase") }

			end

			describe "Delete a class" do
		
				before do
					expect { click_link "Borrar Clase" }.to change(Lecture, :count).by(-1)
				end

				it { should have_selector("div.alert.alert-success") }
				it { should have_content('Clase borrada') }
				it { should have_title("Grupo #{group.name.titleize}") }
				it { should have_link("Nueva Clase") }

			end
		end
	end
end