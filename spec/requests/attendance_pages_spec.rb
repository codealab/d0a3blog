# encoding: UTF-8
# Capybara.current_driver = :selenium_chrome
require 'spec_helper'

describe 'Attendances pages' do

	subject { page }

	let(:user) { create(:user, :is_admin, :is_instructor) }

	let(:group) { create(:group) }
	let(:lecture) { create( :lecture, group: group ) }
	
	let(:person) { create(:person) }
	let(:family) { Family.create({ name:'Nueva Familia', responsible_id: person.id }) }
	let(:child) { family.family_members.create( name: "Joaquín", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/2014", family_roll: "Hijo") }
	let(:other_child) { family.family_members.create( name: "Mariana", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"F", dob:"20/02/2014", family_roll: "Hija") }

	before do
		sign_in user
		group.spots.create( child_id: child.id )
		group.spots.create( child_id: other_child.id )
		lecture.attendances.create( spot_id: group.spots.first.id )
		visit new_group_lecture_attendance_path(group,lecture)
	end

	describe 'Index Attendances' do

		it { should have_content('Asistencias') }
		it { should have_content("Inscripciones") }
		it { should have_content("#{lecture.possible_attendances.count} inscritos activos") }
		it { should have_content("#{lecture.attendances.count} Asistentes") }

	end

	describe 'new attendance' do

		before "should create a attendance" do
			expect { click_link "child_selector_1" }.to change(Attendance, :count).by(1)
			visit new_group_lecture_attendance_path(group,lecture)
		end

		it { should have_content("#{lecture.attendances.count} Asistentes") }

	end

	describe "destroy attendance" do

		before "should erase attendance in lecture" do
			expect { click_link "remove_attendance_0" }.to change(Attendance, :count).by(-1)
			visit new_group_lecture_attendance_path(group,lecture)
		end

		it { should have_content("#{lecture.attendances.count} Asistentes") }

	end

end