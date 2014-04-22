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

	before { sign_in user }

	
	describe "Spot page" do

		before { Spot.create({ child_id: children.id, tutor_id: person.id, group_id: group.id }) }

		describe "index" do
			before { visit group_path(group) }

			it 'should render group actions' do			
				expect(page).to have_content("Inscripciones")
			end
		end

		#edit

		describe "destroy" do

			before { visit edit_group_spot_path(group, group.spots.first) }
			it "should delete a spot" do
				expect { click_link "Desinscripción" }.to change(Spot, :count).by(-1)
			end
		end

	end
end