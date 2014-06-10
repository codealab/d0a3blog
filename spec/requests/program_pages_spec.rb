# encoding: UTF-8
require 'spec_helper'

describe "program pages" do

	subject { page }

	let(:user) { create(:user, :is_admin) }
	let(:program) { create(:program) }

	before do
		sign_in user
		10.times { create(:program) }
		create(:exercise)
		visit programs_path
	end

	describe "index page" do
		
		before { visit programs_path }
		
		describe 'page' do
			it { should have_title("Todos los Programas") }
			it { should have_link("Nuevo Programa", href: new_program_path) }
		end

		describe 'Programs List' do
			it "should list each program" do
				Program.all.each do |program|
					expect(page).to have_link("#{program.name}", href: program_path(program) )
					expect(page).to have_selector('td', text: program.lectures )
				end
			end
		end

	end

	describe 'Create a new program' do

		before { visit new_program_path }
		
		describe 'page' do
			it { should have_title("Nuevo Programa") }
			it { should have_link("Regresar a Programas", href: programs_path) }
		end

		describe 'just clicking' do
			before { click_button "Guardar" }
			it { should have_title("Nuevo Programa") }
			it { should have_content("La forma contiene 4 errores") }
		end

		describe 'with invalid information' do
			it "should not create a program" do
				expect { click_button "Guardar" }.not_to change(Program, :count)
			end

			describe 'after submission form' do
				before { click_button "Guardar" }
				it { should have_title("Nuevo Programa") }
				it { should have_content("La forma contiene 4 errores") }
			end
		end

		describe "with valid information" do
			before do
				fill_in "program[name]", :with => 'Rename Program'
				fill_in "program[min_age]", :with => 0
				fill_in "program[max_age]", :with => 120
				fill_in "program[description]", :with => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.'
				fill_in "program[lectures]", :with => 20 
				expect { click_button "Guardar" }.to change(Program, :count).by(1)
			end
		end

	end

	describe "edit program" do
		
		before do
			visit edit_program_path(program)
		end

		describe 'should program information' do
			it { should have_title("Editar Programa") }
			it { should have_button("Regresar a Programa") }
		end

		describe "with invalid information" do

			before do
				fill_in "program[name]", :with => " "
				fill_in "program[min_age]", :with => " "
				fill_in "program[max_age]", :with => " "
				fill_in "program[lectures]", :with => " "
				fill_in "program[description]", :with => " "

				click_button "Guardar"
			end
			it { should have_content("La forma contiene 4 errores") }
		end

		describe "with valid information" do

			before do
				fill_in "program[name]", :with => "Renamed program"
				fill_in "program[min_age]", :with => 10
				fill_in "program[max_age]", :with => 30
				fill_in "program[lectures]", :with => 40 
				fill_in "program[description]", :with => "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Molestiae, placeat, sequi, obcaecati error eveniet iure repellendus."

				click_button "Guardar"
			end
			
			it { should have_selector("div.alert.alert-success") }
			it { should have_content("Actualización exitosa") }
			it { should have_title("Renamed program ( 10 - 30 semanas )") }

		end
	end

	describe 'destroy program' do

		before { visit edit_program_path(program) }

		describe "show program information" do
			it { should have_title "Editar Programa" }
			it { should have_button "Borrar Programa" }
		end

		describe "click on delete" do
			before do
				expect { click_link "Borrar Programa" }.to change(Program, :count).by(-1)
			end
			it { should have_selector("div.alert.alert-success") }
			it { should have_content('Programa borrado') }
		end

	end

	describe "build relation lecture/day/program " do

		before { visit "/programs/#{program.id}/program_relations/new?lecture_id=1" }

		describe "should show details possible lectures" do
			it { should have_content("Total de actividades para este programa: 1") }
			it { should have_content("Exercise") }
			it { should have_content('Este es un objetivo en actividad') }
			it { should have_content('Este es la descripción de la actividad') }
			it { should have_content("Leer más") }
		end

		it "should create a program relation" do
			expect { click_link "program_relation_0" }.to change(ProgramRelation, :count).by(1)
		end

	end

end