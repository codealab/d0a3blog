	# encoding: UTF-8
require 'spec_helper'

describe 'Person pages' do
	
	subject { page }
	
	let(:user) { create(:user, :is_admin) }
	before { sign_in user }

	describe 'Index People' do
		before do
	  	10.times { create(:person) }
			visit people_path
		end

		it { should have_title('Todos los Miembros') }

		describe 'Should render people list' do
			it "should list each person" do
				Person.all.each do |member|
					expect(page).to have_selector('a', text: member.name)
				end
			end
		end
	end

	describe 'Show person' do
		let(:family) { FactoryGirl.create(:family) }
		let(:member) { family.family_members.create( name: "Rodrigo", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"22/03/1969", family_roll: "Padre") }
		before { visit family_person_path(family,member) }
		it { should have_content("Edad") }
		it { should have_content("Tutor") }
		it { should have_content("Familia") }
	end

end