# encoding: UTF-8
require 'spec_helper'

describe 'Spot pages' do

	subject { page }

	let(:user) { create(:user, :is_admin, :is_instructor) }
	let(:group) { create(:group) }
	let(:person) { create(:person) }
	let(:family) { Family.create({ name: 'Nueva Familia', responsible_id: person.id }) }

	let(:children) { family.family_members.create( name: "Joaquín", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/2014", family_roll: "Hijo") }
	let(:spot) { group.spots.create({ child_id: spot.id, tutor_id: person.id }) }

	before {
		sign_in user
		Spot.create({ child_id: children.id, tutor_id: person.id, group_id: group.id })
	}

	describe "group actions" do
		before { visit group_path(group) }

		it 'should render group actions' do			
			expect(page).to have_content("Inscripciones")
		end
	end

	describe "index group" do
		before { visit group_path(group) }

		it 'should render spot list' do
			group.spots.each do |spot|					
				expect(page).to have_selector('a', text: spot.child.full_name)
				expect(page).to have_content('a', text: spot.tutor.full_name)
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
		end

		describe 'when click on item' do
			it "should create a spot" do
				expect { click_link "child_selector_1" }.to change(Spot, :count).by(1)
			end
		end
	end

	describe "Spot page" do

		before do
			Spot.create({ child_id: children.id, tutor_id: person.id, group_id: group.id })
		end

		describe "edit" do

			before { visit group_spot_path(group, group.spots.first) }
			it { should have_button('Editar Spot') }
			it { should have_content('Pagos') }
				
		end

	end
	
	describe "destroy" do

		before { visit edit_group_spot_path(group, group.spots.first) }
		it "should delete a spot" do
			expect { click_link "Desinscripción" }.to change(Spot, :count).by(-1)
		end

	end


end