# encoding: UTF-8
require 'spec_helper'
require 'ruby-debug'

describe "Family-Person pages" do

  subject { page }
  let(:user) { create(:user, :is_admin) }
  before { sign_in user }

  let(:family) { create(:family, :spesific_name) }

  describe "index" do

		let(:address) { create(:address, family: family)}
		let(:person1) { family.family_members.create( name: "Fernando", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/1995", family_roll: "Hijo") }
		let(:person2) { family.family_members.create( name: "Alejandra", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"F", dob:"21/02/1996", family_roll: "Hija") }
		let(:person3) { family.family_members.create( name: "Rodrigo", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"22/03/1969", family_roll: "Padre") }
    
    before do
      visit family_path(family)
    end

    describe "page" do
    	specify { expect(address.family).to  eq family }

	    it { should have_title('Familia: Vega') }
			it { should have_link("Falta Información de Contacto", href: new_family_address_path(family))}
			it { should have_link("Regresar a Socios", href: families_path ) }
			it { should have_link("Nuevo Miembro", href: new_family_person_path(family))}
			it { should have_link("Editar Nombre de la Familia", href: edit_family_path(family))}

			it { should have_content("Contacto") }
			# HELP - The Addres is not working, it is not recognizing it, and it is strange that on the address specs works fine. 
			# specify { expect(family.address).to  eq address }
			# it { should have_content("Arteaga Y Salazar,44 ,Int 3,Algo,Contadero, Cuajimalpa, México, Distrito Federal, México, 01190") }
			# it { should have_link("Editar Contacto", href: edit_family_address_path(family,address))}
		end	

    describe "Members List" do

      it "should list each member" do
        Person.all.each do |person|
          expect(page).to have_link(person.name, href: person_path(person))
          expect(page).to have_selector('a', text: person.name)
          expect(page).to have_selector('a', text: person.name)
          expect(page).to have_selector('td', text: person.first_last_name) 
          expect(page).to have_selector('td', text: person.second_last_name) 
          expect(page).to have_selector('td', text: person.dob) 
          expect(page).to have_selector('td', text: person.family_roll) 
        end
      end
    end
  end # describe index

  # describe "index when family has no members" do 
  # 	before {visit family_path(family)} 

  # 	it { should have_link("Falta Información de Contacto", href: edit_family_address_path(family,address ))}
  # 	it { should have_link("Borrar Familia", href: new_family_address_path(family))}
  # end

  describe "New Person" do
		let(:person) { family.family_members.create( name: "Fernando", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/1995", family_roll: "Hijo") }
		before do
			visit new_family_person_path(family,person)
		end

		describe "page" do
			it { should have_title("Nuevo Miembro:") }
			it { should have_content("Nuevo Miembro:") }
			it { should have_link("Regresar a Familia", href: family_path(family))}
		end

		describe "just clicking" do
			before { click_button "Guardar" }

			it { should have_title("Nuevo Miembro: Vega") }
		end
 

    describe "with invalid information" do
      it "should not create a person" do
        expect { click_button "Guardar" }.not_to change(Person, :count)
      end

      describe "after submission" do
        before { click_button "Guardar" }

       	it { should have_title("Nuevo Miembro: Vega") }
      end
    end

	end # new person


  describe "Edit Person" do
		let(:person) { family.family_members.create( name: "Fernando", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/1995", family_roll: "Hijo") }
		before do
			visit edit_family_person_path(family,person)
		end

		describe "page" do
			it { should have_title("Editar a: Fernando Garcia Lopez") }
			it { should have_content("Editar a: Fernando Garcia Lopez") }
			it { should have_link("Regresar a Familia", href: family_path(family))}
		end

		describe "just clicking" do
			before { click_button "Guardar" }

			it { should have_content('Actualización Exitosa') }
			it { should have_selector('td', text:'M') }
			it { should have_selector('td', text:'Hijo') }
		end

		describe "with valid information" do
			before do
				fill_in "person[name]",           with: "Juan"
				fill_in "person[first_last_name]", with: "Perez"
				fill_in "person[second_last_name]", with: "Portilla"
				choose "person_sex_f"
				select 'Padre', from: 'person[family_roll]'
				select  '2002', from: 'person[dob(1i)]'
				select  'February' , from: 'person[dob(2i)]'
				select  '21' , from: 'person[dob(3i)]'
				# Otra forma de hacerlo	
				# within '#person_dob_3i' do
				#   find("option[value='21']").select_option
				# end

				click_button "Guardar"
			end

			it { should have_selector('div.alert.alert-success') }
			it { should have_content('Actualización Exitosa') }
			it { should have_selector('a', text:'Juan') }
			it { should have_selector('td', text:'F') }
			it { should have_selector('td', text:'Padre') }
			it { should have_selector('td', text:'2002-02-21') }

			specify { expect(person.reload.name).to  eq "Juan" }
			specify { expect(person.reload.first_last_name).to  eq "Perez" }
			specify { expect(person.reload.second_last_name).to  eq "Portilla" }
			specify { expect(person.reload.sex).to  eq "F" }
			specify { expect(person.reload.family_roll).to  eq "Padre" }
			specify { expect(person.reload.dob).to  eq "2002-02-21".to_date }
		end

		describe "with valid information without modifying name and lastnames" do
			before do
				choose "person_sex_f"
				select 'Padre', from: 'person[family_roll]'

				click_button "Guardar"
			end

			it { should have_selector('div.alert.alert-success') }
			it { should have_content('Actualización Exitosa') }
			it { should have_selector('td', text:'F') }
			it { should have_selector('td', text:'Padre') }

			specify { expect(person.reload.sex).to  eq "F" }
			specify { expect(person.reload.family_roll).to  eq "Padre" }
		end
	end # Edit Person
end #describe-Family-Person-Pages

 	 # let(:address) {family.address.create_address(calle: "Arteaga y Salazar", num_ext:"44", num_int:"3", 
   #                localidad:"Algo", colonia:"contadero", municipio: "cuajimalpa",
   #                ciudad:"México",estado:"Distrito Federal", pais:"México", 
   #                codigo_postal:"01190", telefono:"558130387", celular:"5512946184", 
   #                email:"user@example.com")}



