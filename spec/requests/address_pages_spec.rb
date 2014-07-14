# encoding: UTF-8
require 'spec_helper'

describe "Address pages" do

  subject { page }

  let(:family) { create(:family, :specific_name) }
  let(:user) { create(:user, :is_admin) }
  
  before { sign_in user }

  describe "Create Address" do
    before do
      visit new_family_address_path(family)
    end

    describe "page" do
      it { should have_title('Crear contacto de la Familia: Vega') }
      it { should have_link("Regresar a Familia", href: family_path(family))}
    end

    describe "just clicking" do
      before { click_button "Crear Dirección" }

      it { should have_title('Crear contacto de la Familia: Vega') }
      it { should have_content('La forma contiene 3 errores') }
    end

    describe "with valid information" do
      before do
        fill_in "address[calle]",              with: "Nueva Calle"
        fill_in "address[num_ext]",            with: "999"
        fill_in "address[num_int]",            with: "0"
        fill_in "address[localidad]",          with: "El Cedro"
        fill_in "address[referencia]",         with: "Por ahí"
        fill_in "address[colonia]",            with: "Los Pinos"
        fill_in "address[municipio]",          with: "Santa Barbara"
        fill_in "address[ciudad]",             with: "Los Angeles"
        fill_in "address[estado]",             with: "California"
        fill_in "address[pais]",               with: "Estados Unidos"
        fill_in "address[codigo_postal]",      with: "02200"
        fill_in "address[telefono]",           with: "91919191"
        fill_in "address[celular]",            with: "22224444"
        fill_in "address[email]",              with: "user@rails.com"
        expect { click_button "Crear Dirección" }.to change(Address, :count).by(1)
      end

      it { should have_selector('div.alert.alert-success') }
      it { should have_content('Creación Exitosa') }
      it { should have_content("Nueva Calle, 999, Int 0, El Cedro, Los Pinos, Santa Barbara, Los Angeles, California, Estados Unidos, 02200") }
      it { should have_content("Tel: 91919191, Cel: 22224444, Email: user@rails.com") }
      it { should have_content("Referencia: Por ahí") }
    end # valid info
  end # New Address


  describe "Edit Address" do
    let(:address) { create(:address, family: family) }
    
    before(:each) do
      visit edit_family_address_path(family,address)
    end

    describe "page" do
      it { should have_title('Editar contacto de la Familia: Vega') }
      it { should have_link("Regresar a Familia", href: family_path(family))}
    end

    describe "just clicking" do
      before { click_button "Guardar Dirección" }

      it { should have_content('Actualización Exitosa') }
      it { should have_content("Arteaga Y Salazar") }
      it { should have_content("Tel: 558130387") }
    end

    describe "with valid information" do
      before do
        fill_in "address[calle]",              with: "Nueva Calle"
        fill_in "address[num_ext]",            with: "999"
        fill_in "address[num_int]",            with: "0"
        fill_in "address[localidad]",          with: "El Cedro"
        fill_in "address[referencia]",         with: "Por ahí"
        fill_in "address[colonia]",            with: "Los Pinos"
        fill_in "address[municipio]",          with: "Santa Barbara"
        fill_in "address[ciudad]",             with: "Los Angeles"
        fill_in "address[estado]",             with: "California"
        fill_in "address[pais]",               with: "Estados Unidos"
        fill_in "address[codigo_postal]",      with: "02200"
        fill_in "address[telefono]",           with: "91919191"
        fill_in "address[celular]",            with: "22224444"
        fill_in "address[email]",              with: "user@rails.com"
        click_button "Guardar Dirección"
      end

      it { should have_selector('div.alert.alert-success') }
      it { should have_content('Actualización Exitosa') }
      it { should have_content("Nueva Calle, 999, Int 0, El Cedro, Los Pinos, Santa Barbara, Los Angeles, California, Estados Unidos, 02200") }
      it { should have_content("Tel: 91919191, Cel: 22224444, Email: user@rails.com") }
      it { should have_content("Referencia: Por ahí") }

      specify { expect(address.reload.calle).to          eq "Nueva Calle" }
      specify { expect(address.reload.num_ext).to        eq "999" }
      specify { expect(address.reload.num_int).to        eq "0" }
      specify { expect(address.reload.localidad).to      eq "El Cedro" }
      specify { expect(address.reload.referencia).to     eq "Por ahí" }
      specify { expect(address.reload.colonia).to        eq "Los Pinos" }
      specify { expect(address.reload.municipio).to      eq "Santa Barbara" }
      specify { expect(address.reload.ciudad).to         eq "Los Angeles" }
      specify { expect(address.reload.estado).to         eq "California" }
      specify { expect(address.reload.pais).to           eq "Estados Unidos" }
      specify { expect(address.reload.codigo_postal).to  eq "02200" }
      specify { expect(address.reload.telefono).to       eq "91919191" }
      specify { expect(address.reload.celular).to        eq "22224444" }
      specify { expect(address.reload.email).to          eq "user@rails.com" }
    end # valid info

    describe "with invalid information" do
      before do
        fill_in "address[calle]",              with: " "
        fill_in "address[num_ext]",            with: " "

        click_button "Guardar Dirección"
      end

      it { should have_title('Editar contacto de la Familia: Vega') }
      it { should have_content('La forma contiene 2 errores') }
    end
  end # Edit Address

end #describe-Family pages