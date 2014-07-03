	# encoding: UTF-8
require 'spec_helper'

describe 'Person pages' do
	
	subject { page }
	
	let(:user) { create(:user, :is_admin) }
	before { sign_in user }

	describe 'Index People' do
		before do
	  	10.times { create(:person) }
			visit people_path
		end

		it { should have_title('Todos los Miembros') }

		describe 'Should render people list' do

			it "should list each person" do
				Person.all.each do |member|
					expect(page).to have_selector('a', text: member.name)
				end
			end
		end

	end

	describe "Create a new member" do
		let(:family) { FactoryGirl.create(:family) }

		before { visit family_path(family) }

		describe "click on new member" do
			
			before { click_link('Nuevo Miembro') }

			describe "with invalid information" do
				before { click_button('Crear Miembro') }
	          	it { should have_content('La forma contiene 5 errores') }
			end

		end
	end

	describe 'Show person' do
		let(:family) { FactoryGirl.create(:family) }
		let(:member) { family.family_members.create( name: "Rodrigo", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"22/03/1969", family_roll: "Padre") }
		before { visit family_person_path(family,member) }
		it { should have_content("Familia") }
		it { should have_content("Responsable") }
		it { should have_content("Edad") }
		it { should have_content("Rol Familiar") }
	end

	describe 'Edit person' do
		let(:family) { FactoryGirl.create(:family) }
		let(:member) { family.family_members.create( name: "Rodrigo", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"22/03/1969", family_roll: "Padre") }
		before { visit edit_family_person_path(family,member) }

		describe "with invalid information" do
			before do
				fill_in "person[name]",	:with => " "
				fill_in "person[first_last_name]",	:with => " "
				fill_in "person[second_last_name]",	:with => " "

				click_button "Guardar Miembro"
			end

			it { should have_content("La forma contiene 3 errores") }

		end

		describe "with valid information" do
			before do
				fill_in "person[name]",	:with => "Adela"
				fill_in "person[first_last_name]",	:with => "Guzmán"
				fill_in "person[second_last_name]",	:with => "Romero"
				select 'Madre', from: 'person[family_roll]'

				click_button "Guardar Miembro"
			end

			it { should have_content("Actualización Exitosa") }

		end

	end
end