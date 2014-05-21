# encoding: UTF-8
require 'spec_helper'

describe "Payment pages" do

  subject { page }

  let(:user) { create(:user, :is_admin) }
  let(:person) { create(:person) }
  let(:group) { create(:group) }
  let(:family) { Family.create({ name:'Nueva Familia', responsible_id: person.id }) }
  let(:hijo) { family.family_members.create( name: "Joaquín", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/2014", family_roll: "Hijo") }
  let(:spot) { group.spots.create(:child_id => hijo.id, :group_id => group ) }
  let(:payment) { create(:payment, :spot => spot) }

  before { sign_in user }

  describe 'Index Exercises' do
    before do
      5.times { create(:payment, :spot => spot ) }
      visit payments_path
    end

    it { should have_title('Todos los Pagos') }

    describe 'Should render payment list' do
      it "should info payment" do
        expect(page).to have_content("Fecha")
        expect(page).to have_content("Niño")
        expect(page).to have_content("Tutor")
        expect(page).to have_content("Grupo")
        expect(page).to have_content("Cantidad")
        expect(page).to have_content(Payment.all.count)
      end
    end
  end

  describe 'Payments in spot' do

    before do
      Spot.create({ child_id: hijo.id, group_id: group.id })
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
          it { should have_content('La forma contiene 2 errores') }
        end

        describe 'with valid information' do

          before do
            select "#{ Date.today.to_date.day }", from: "payment[date(3i)]"
            select "#{ I18n.l Date.today.to_date, :format => '%B' }", from: "payment[date(2i)]"
            select "#{ Date.today.to_date.year }", from: "payment[date(1i)]"
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