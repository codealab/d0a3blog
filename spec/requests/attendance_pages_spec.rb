# encoding: UTF-8
require 'spec_helper'

describe 'Spot pages' do

	subject { page }

	let(:user) { create(:user, :is_admin, :is_instructor) }
	let(:person) { create(:person) }
	let(:family) { Family.create({ name:'Nueva Familia', responsible_id: person.id }) }
	let(:hijo) { family.family_members.create( name: "Joaquín", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/2014", family_roll: "Hijo") }

	before do
	    sign_in user
	    @group = create(:group) 
		@lecture = create( :lecture, group: @group )
	    @spot = @group.spots.create( child_id: hijo.id, tutor_id: person.id )
	end

	describe 'Index Attendances' do

		before { visit new_group_lecture_attendance_path(@group,@lecture) }

		describe 'index page' do
			# it { should have_content('Asistencias') }
			it { should have_content("Inscripciones") }
			it { should have_content("#{@group.spots.count} Inscritos") }
			# it { should have_content("#{@lecture.attendances.count} Asistentes") }
		end

		# describe 'when click on item' do
		# 	it "should create a spot" do
		# 		expect { click_link "child_selector_0" }.to change(Spot, :count).by(1)
		# 	end
		# end

		before do
			family.family_members.create( name: "Fernando", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/2014", family_roll: "Hijo")
			visit new_group_spot_path(@group)
		end

		describe 'spot page' do

			it { should have_title('Inscripciones') }
			it { should have_content('Regresar al Grupo') }
			it { should have_content(@group.spots.count) }

		end

	end

	describe "Spot page" do

		before { Spot.create({ child_id: hijo.id, tutor_id: person.id, group_id: @group.id }) }

		describe "index" do
			before { visit group_path(@group) }

			it 'should render @group actions' do			
				expect(page).to have_content("Inscripciones")
			end
		end

		#edit

		describe "destroy" do

			before { visit edit_group_spot_path(@group, @group.spots.first) }
			it "should delete a spot" do
				expect { click_link "Desinscripción" }.to change(Spot, :count).by(-1)
			end
		end

	end
end