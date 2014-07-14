# encoding: UTF-8
require 'spec_helper'

describe 'Group pages' do
	subject { page }

	let(:user) { create(:user, :is_admin, :is_instructor) }
	let(:group) { create(:group) }

  	before do
		sign_in user
		10.times { create(:group) }
		visit groups_path
	end

	describe 'Index Groups' do

		it { should have_title('Nuestros Grupos') }
		it { should have_content(Group.where("finish_date <= :start_date", { start_date: Date.today }).count)}
	
		describe 'Should render group list' do
			it "should list each group" do
				Group.where("finish_date <= :start_date", { start_date: Date.today }).each do |g|
					expect(page).to have_selector('a', text: g.name.titleize )
				end
			end
			it { should have_button('Nuevo Grupo') }
			it { should have_button('Grupos Pasados') }
		end
	
	end

	describe 'New group' do

		before { visit new_group_path }

		describe "show create group info" do
			it { should have_title('Nuevo Grupo') }
			it { should have_button('Regresar a los Grupos') }
		end

		describe 'with invalid information' do
			it "should not create a group" do
				expect { click_button "Crear Grupo" }.not_to change(Group, :count)
			end
			describe "error messages" do
				before { click_button "Crear Grupo" }
				it { should have_content('La forma contiene 8 errores') }
			end
		end

		describe 'with valid information' do
			before do
				fill_in "group[name]", :with => "New Group"
				# within '#group_user_id' do
				# 	find("option[1]").select_option #For select the first option
				# end
				# within '#group_init_date_1i' do
				# 	find("option[1]").select_option #For select the first option
				# end
				# within '#group_finish_date_1i' do
				# 	find("option[1]").select_option #For select the first option
				# end
				select("#{user.name}", :from => 'group[user_id]')
				select "#{Date.today.to_date.year}", from: "group[init_date(1i)]"
				select "#{I18n.l Date.today.to_date, :format => '%B'}", from: "group[init_date(2i)]"
				select "12", from: "group[init_date(3i)]"
				select "#{I18n.l Date.today.to_date+1.month, :format => '%B'}", from: "group[finish_date(2i)]"
				select "12", from: "group[finish_date(3i)]"
				select "#{Date.today.to_date.year}", from: "group[finish_date(1i)]"
				fill_in "group[min_age]", :with => "0"
				fill_in "group[max_age]", :with => "100"
				fill_in "group[cost]", :with => "999"
				fill_in "group[location]", :with => "Aula Uno"

				expect { click_button "Crear Grupo" }.to change(Group, :count).by(1)

			end

			it { should have_selector("div.alert.alert-success") }
			it { should have_content('Creación Exitosa') }

		end
	end

	describe 'Show group information' do

		before { visit group_path(group) }

		describe 'Show group information' do
			it { should have_title("Grupo #{group.name.titleize}: #{group.min_age} a #{group.max_age} meses") }
			it { should have_link('Administrar Clases') }
			it { should have_link('Editar Grupo') }
		end

	end

	describe "edit group" do

		before { visit edit_group_path(group) }

		describe "edit" do
			it { should have_title('Editar Grupo') }
			it { should have_content('Datos del grupo') }
		end

		describe "with invalid information" do

			before do
				# select("#{user.name}", :from => 'group[user_id]') #activate to return only 1 error. For some reason the test return empty user_id
				fill_in "group[name]", :with => " "
			
				click_button "Guardar Grupo" 
			end

			it { should have_content('La forma contiene 2 errores') }

		end

		describe "with valid information" do
			
			before do
				select("#{user.name}", :from => 'group[user_id]') 
				fill_in "group[name]", :with => "Renamed Group"
				select "#{Date.today.to_date.year}", from: "group[init_date(1i)]"
				select "#{I18n.l Date.today.to_date, :format => '%B'}", from: "group[init_date(2i)]"
				select "18", from: "group[init_date(3i)]"
				select "#{Date.today.to_date.year}", from: "group[finish_date(1i)]"
				select "#{I18n.l Date.today.to_date+2.month, :format => '%B'}", from: "group[finish_date(2i)]"
				select "12", from: "group[finish_date(3i)]"
				fill_in "group[min_age]", :with => "0"
				fill_in "group[max_age]", :with => "100"
				fill_in "group[location]", :with => "Aula Dos"

				click_button "Guardar Grupo"
			end

			it { should have_selector("div.alert.alert-success") }
			it { should have_content('Actualización Exitosa') }
			it { should have_content("Renamed Group: 0 a 100 meses" ) }
			it { should have_content('$280') }
			it { should have_content("Aula Dos") }

		end

	end

	describe 'Destroy group' do
		
		before { visit edit_group_path(group) }
		
		it { should have_button('Borrar Grupo') }
		it { should have_link('Borrar Grupo', href: group_path(group) ) }
		
		describe "should delete an group" do

			before do
				expect { click_link "Borrar Grupo" }.to change(Group, :count).by(-1)
			end

			it { should have_title('Nuestros Grupos') }
			it { should have_content("Grupo Borrado") }

		end
	end

end