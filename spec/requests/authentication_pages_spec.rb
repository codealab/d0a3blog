# encoding: UTF-8
require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      
      before { click_button "Sign in" }
      it { should have_selector('div.alert.alert-danger') }
      
      describe "after visiting another page" do
        before { visit signin_path }
        it { should_not have_content('div.alert.alert-danger') }
      end

      describe "visiting groups page" do
        before { visit groups_path }
        it { should_not have_content('div.alert.alert-danger') }
        it { should have_content('Inicia sesión') }
      end

    end

    describe "with valid information" do

      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_link('Cuenta') }
      it { should have_link('Familias') }
      it { should have_link('Grupos') }

      describe "visit families" do
        before { visit families_path }
        it { should have_content('Nuestras Familias') }
        it { should have_button('Nueva Familia') }

        it "should list each family" do
          Family.all.each do |family|
            expect(page).to have_link(family.name, href: family_path(family))
            expect(page).to have_selector('a', text: family.name)
          end
        end

        describe "create a family" do
          before { click_button "Nueva Familia" }
          it { should have_button('Nueva Familia') }
          it { should have_title('Nuestras Familias') }
        end
      end

      describe "edit profile" do
        before { visit edit_user_path(user) }
        it { should have_title("Editar #{user.name}") }
        it { should have_button('Cambiar contraseña') }
        it { should have_button('Guardar') }

        describe "change password" do
          before { visit edit_password_reset_path(user) }
          it "should render a new form" do
            expect(page).to have_title("Cambiar contraseña de: #{user.name}")
          end

          describe "with invalid information" do
            before { click_button "Guardar" }
            it { should have_button('Guardar') }
            it { should have_selector('div.alert.alert-danger') }
          end

          describe "with valid information" do
            before do
              fill_in "user[old_password]", with: "foobar"
              fill_in "user[password]", with: "barfoo"
              fill_in "user[password_confirmation]", with: "barfoo"
              click_button "Guardar"
            end

            it { should have_title("#{user.name}") }
            it { should have_content("Password cambiado") }
            it { should have_content("#{user.name}") }

          end
        end
      end
    end

    describe "with valid information and user is admin" do

      let(:user) { FactoryGirl.create(:user, :is_admin) }
      before { sign_in user }

      describe "visit families" do
        before { visit families_path }
        it { should have_content('Nuestras Familias') }
        it { should have_button('Nueva Familia') }

        describe "create a family" do
          before { visit new_family_path }
          it { should have_title('Nueva Familia') }

          describe "with invalid information" do
            before { click_button "Crear Familia" }
            it { should have_button('Crear Familia') }
            it { should have_selector('div.alert.alert-danger') }
            it { should have_content('1 error') }
          end

          describe "with valid information" do
            before do
              fill_in "family[name]", with: "Hernández Rodríguez"
              expect { click_button "Crear Familia" }.to change(Family, :count).by(1)
            end
            it { should have_title('Familia: Hernández Rodríguez') }
            it { should have_selector('div.alert.alert-success') }
          end
        end
      end

      describe "edit profile" do
        before { visit edit_user_path(user) }
        it { should have_title("Editar #{user.name}") }
        it { should have_button('Cambiar contraseña') }
        it { should have_button('Guardar') }

        describe "change password" do
          before { visit edit_password_reset_path(user) }
          it "should render a new form" do
            expect(page).to have_title("Cambiar contraseña de: #{user.name}")
          end

          describe "with invalid information" do
            before { click_button "Guardar" }
            it { should have_button('Guardar') }
            it { should have_selector('div.alert.alert-danger') }
          end

          describe "with valid information" do
            before do
              fill_in "user[password]", with: "barfoo"
              fill_in "user[password_confirmation]", with: "barfoo"
              click_button "Guardar"
            end

            it { should have_title("#{user.name}") }
            it { should have_content("Password cambiado") }
            it { should have_content("#{user.name}") }

          end
        end
      end

      describe "edit other profile" do
        let(:other_user) { User.first }
        before { visit edit_user_path(other_user) }
        it { should have_title("Editar #{other_user.name}") }
        it { should have_button('Cambiar contraseña') }
        it { should have_button('Guardar') }

        describe "change password" do
          before { visit edit_password_reset_path(other_user) }
          it "should render a new form" do
            expect(page).to have_title("Cambiar contraseña de: #{other_user.name}")
          end

          describe "with invalid information" do
            before { click_button "Guardar" }
            it { should have_button('Guardar') }
            it { should have_selector('div.alert.alert-danger') }
          end

          describe "with valid information" do
            before do
              fill_in "user[password]", with: "barfoo"
              fill_in "user[password_confirmation]", with: "barfoo"
              click_button "Guardar"
            end

            it { should have_title("#{user.name}") }
            it { should have_content("Password cambiado") }
            it { should have_content("#{user.name}") }

          end
        end
      end
    end

    describe "with valid information and user is instructor" do

      let(:user) { FactoryGirl.create(:user, :is_instructor) }
      before { sign_in user }

      describe "visit groups" do
        before { visit groups_path }
        it { should have_content('Nuestros Grupos') }
        it { should have_button('Nuevo Grupo') }

        describe "create a group" do

          before { visit new_group_path }
          it { should have_title('Nuevo Grupo') }

          describe "with invalid information" do
            before { click_button "Guardar" }
            it { should have_button('Guardar') }
            it { should have_selector('div.alert.alert-danger') }
            it { should have_content('1 error') }
          end

          describe "with valid information" do
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
      end

      describe "edit profile" do
        before { visit edit_user_path(user) }
        it { should have_title("Editar #{user.name}") }
        it { should have_button('Cambiar contraseña') }
        it { should have_button('Guardar') }

        describe "change password" do
          before { visit edit_password_reset_path(user) }
          it "should render a new form" do
            expect(page).to have_title("Cambiar contraseña de: #{user.name}")
          end

          describe "with invalid information" do
            before { click_button "Guardar" }
            it { should have_button('Guardar') }
            it { should have_selector('div.alert.alert-danger') }
          end

          describe "with valid information" do
            before do
              fill_in "user[old_password]", with: "foobar"
              fill_in "user[password]", with: "barfoo"
              fill_in "user[password_confirmation]", with: "barfoo"
              click_button "Guardar"
            end

            it { should have_title("#{user.name}") }
            it { should have_content("Password cambiado") }
            it { should have_content("#{user.name}") }

          end
        end
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
      end  
    end  
  end
end