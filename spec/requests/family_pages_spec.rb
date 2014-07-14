# encoding: UTF-8
require 'spec_helper'

describe "Family pages" do

  subject { page }
  let(:user) { create(:user, :is_admin) }

  before do
    sign_in user
    10.times {create(:family)}
    visit families_path
  end

  describe "index" do

    it { should have_title('Nuestras Familias') }
    it { should have_link("Nueva Familia", href: new_family_path)}
    it { should have_button("Nueva Familia")}
    
    describe "Family List" do
      it "should list each family" do
        
        Family.order("name ASC").each do |family|
          expect(page).to have_link(family.name, href: family_path(family))
          expect(page).to have_selector('a', text: family.name)
        end
        
      end
    end
  end

  describe "To passive" do
    let(:first_family) { Family.first }
    before { visit "/families?filter=pasive" }
    
    describe "Family List" do
      before { click_link("family_status_0") }
      it "toggle" do
        expect { should have_button("DESACTIVAR") }
        expect { should have_button("Volver a familias") }
        expect { first_family.status eq false }
      end
    end
  end

end