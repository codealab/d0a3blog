# encoding: UTF-8
require 'spec_helper'

describe 'Group pages' do
	subject { page }

	let(:user) { create(:user, :is_admin, :is_facilitator) }
	let(:group) { create(:group) }
	let(:person) { create(:person) }
	let(:family) { Family.create({ name:'Nueva Familia', responsible_id: person.id }) }
	let(:spot) { family.family_members.create( name: "Joaquín", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/2014", family_roll: "Hijo") }
	let(:lecture) { create( :lecture, group: group ) }
	let(:hijo) { group.spots.create({ child_id: spot.id, tutor_id: person.id }) }
	let(:payment) { create(:payment) }

  	before do
		sign_in user
		5.times { create(:group) }
		visit groups_path
	end

	describe 'Index Groups' do
	
		it { should have_title('Nuestros Grupos') }
		it { should have_button("Nuevo Grupo") }
	
		describe 'Should render group list' do
			it "should table of exercises" do
				expect(page).to have_content("Aún no existe ni un grupo")
			end
		end	
	end

	describe 'New group' do
		before { visit new_group_path }
		it { should have_title('Nuevo Grupo') }
		it { should have_button('Regresar a los Grupos') }

		describe 'with invalid information' do
			before { click_button('Guardar') }
			it { should have_content('11 errors') }
		end

		describe 'with valid information' do
			before do
				fill_in "group[name]", :with => "New Group"
				within '#group_user_id' do
					find("option[2]").select_option
				end
				within '#group_init_date_1i' do
					find("option[2]").select_option
				end
				within '#group_finish_date_1i' do
					find("option[2]").select_option
				end
				select "Enero", from: "group[init_date(2i)]"
				select "12", from: "group[init_date(3i)]"
				select "Enero", from: "group[finish_date(2i)]"
				select "12", from: "group[finish_date(3i)]"
				fill_in "group[min_age]", :with => "0"
				fill_in "group[max_age]", :with => "100"
				fill_in "group[cost]", :with => "999"
				fill_in "group[location]", :with => "Aula Dos"

				expect { click_button "Guardar" }.to change(Group, :count).by(1)
			end

			it { should have_title("Grupo New Group") }
			it { should have_content('Creación Exitosa') }
		end

	end

	describe 'Show group information' do

		before { visit group_path(group) }

		describe 'Show group information' do
			it { should have_title("Grupo #{group.name.titleize}") }
			it { should have_link('Nueva Clase') }
			it { should have_link('Editar Grupo') }
		end

		describe "visiting the edit group" do
          before { visit edit_group_path(group) }
          it { should have_title('Editar Grupo') }
          it { should have_content('Datos del grupo') }
        end

        describe "with invalid information" do
        	before do
          		visit edit_group_path(group)
          		fill_in "group[name]", :with => " "
          	end
			it "should not update a group" do
				expect { click_button "Guardar" }
			end
			describe "error messages" do
				before { click_button "Guardar" }
				it { should have_content('error') }
			end
		end

		# describe "with valid information", :focus do
		# 	before do
		# 		visit edit_group_path(group)
		# 		fill_in "group[name]", :with => "Renamed Group"
		# 		select 2014, from: "group[init_date(1i)]"
		# 		select "Enero", from: "group[init_date(2i)]"
		# 		select "12", from: "group[init_date(3i)]"
		# 		select 2014, from: "group[finish_date(1i)]"
		# 		select "Enero", from: "group[finish_date(2i)]"
		# 		select "12", from: "group[finish_date(3i)]"
		# 		fill_in "group[min_age]", :with => "0"
		# 		fill_in "group[max_age]", :with => "100"
		# 		fill_in "group[cost]", :with => "999"
		# 		fill_in "group[location]", :with => "Aula Dos"

		# 		click_button "Guardar"
		# 	end

		# 	it { should have_selector("div.alert.alert-success") }
		# 	it { should have_content('Actualización Exitosa') }
		# 	it { should have_selector('td', text: "Renamed Group" ) }
		# 	it { should have_selector('td', text: '0' ) }
		# 	it { should have_selector('td', text: '100' ) }
		# 	it { should have_selector('td', text: '999' ) }
		# 	it { should have_selector('td', text: "Aula Dos" ) }
		# 	it { should have_selector('td#init', text: "01/12/2014" ) }
		# 	it { should have_selector('td#finish', text: "01/12/2014" ) }

		# 	specify { expect(group.reload.name).to eq "Renamed Group" }
		# 	specify { expect(group.reload.min_age).to eq 0 }
		# 	specify { expect(group.reload.max_age).to eq 100 }
		# 	specify { expect(group.reload.cost).to eq 999 }
		# 	specify { expect(group.reload.location).to eq "Aula Dos" }
		# 	specify { expect(group.reload.init_date).to eq "12/01/2014".to_date }
		# 	specify { expect(group.reload.finish_date).to eq "12/01/2014".to_date }
		# end
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

	describe 'New Spots' do
		
		before do
			family.family_members.create( name: "Fernando", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/2014", family_roll: "Hijo")
			visit new_group_spot_path(group)
		end
		
		describe 'spot page' do

			it { should have_title('Inscripciones') }
			it { should have_button('Regresar al Grupo') }
			it { should have_content(group.spots.count) }

		end

		describe 'when click on item' do
			it "should create a spot" do
				expect { click_link "child_selector_0" }.to change(Spot, :count).by(1)
			end
		end

	end

	describe "Spot page" do

		before do
			Spot.create({ child_id: spot.id, tutor_id: person.id, group_id: group.id })
		end

		describe "index" do
			before { visit group_path(group) }

			it 'should render group actions' do			
				expect(page).to have_content("Inscripciones")
				expect(page).to have_content("Nueva Clase")
			end
		end

		describe "edit" do

			before { visit group_spot_path(group, group.spots.first) }
			it { should have_title(hijo.child.name) }
			it { should have_button('Regresar a Grupo') }
			it { should have_button('Editar Spot') }
			it { should have_content('Pagos') }
			
		end

		describe "destroy" do
			before { visit edit_group_spot_path(group, group.spots.first) }
			it "should delete a spot" do
				expect { click_link "Desinscripción" }.to change(Spot, :count).by(-1)
			end
		end

	end

	describe 'Payments in spot' do

		before do
			Spot.create({ child_id: spot.id, tutor_id: person.id, group_id: group.id })
		end

		describe "index" do
			before { visit edit_group_spot_path(group,group.spots.first) }

			it 'should render payment list' do
				group.spots.first.payments.each do |payment|
					expect(page).to have_title("Editar: #{group.spots.first.child.name}")
					expect(page).to have_button('Nuevo Pago')
					expect(page).to have_button('Regresar a Spots')
				end
			end

			describe "click on new payment" do

				before { click_link('Nuevo Pago') }

				describe 'with invalid information' do
					before { click_button('Guardar') }
					it { should have_content('2 error') }
				end

				describe 'with valid information' do

					before do
						select "12", from: "payment[date(3i)]"
						select "Enero", from: "payment[date(2i)]"
						select "2014", from: "payment[date(1i)]"
						fill_in "payment[amount]", :with => "999"
						expect { click_button "Guardar" }.to change(Payment, :count).by(1)
					end

					it "should payments info" do
						expect(page).to have_content('Pago generado exitosamente')
						expect(page).to have_button('Nuevo Pago')
					end

				end

			end

		end

	end

end