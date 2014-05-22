# encoding: UTF-8
require 'spec_helper'

describe 'Attendances pages' do

	subject { page }

	let(:user) { create(:user, :is_admin, :is_instructor) }
	let(:person) { create(:person) }
	let(:family) { Family.create({ name:'Nueva Familia', responsible_id: person.id }) }
	let(:child) { family.family_members.create( name: "Joaquín", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/2014", family_roll: "Hijo") }
	let(:group) { create(:group) }
	let(:lecture) { create( :lecture, group: group ) }
	let(:spot) { group.spots.create( child_id: child.id, tutor_id: person.id ) }
	let(:attendance) { Attendance.create( spot_id: spot.id, lecture_id: lecture.id ) }

	before do
		sign_in user
		10.times { group.spots.create( child_id: child.id, tutor_id: person.id ) }
		visit new_group_lecture_attendance_path(group,lecture)
	end

	describe 'Index Attendances' do

		it { should have_content('Asistencias') }
		it { should have_content("Inscripciones") }
		it { should have_content("#{group.spots.count} Inscritos") }
		it { should have_content("#{lecture.attendances.count} Asistentes") }

	end

	describe 'new attendance' do

		before "should create a attendance" do
			expect { click_link "child_selector_0" }.to change(Attendance, :count).by(1)
			visit new_group_lecture_attendance_path(group,lecture)
		end

		it { should have_content('1 Asistentes') }
	end

	# describe "destroy attendance" do

	# 	before "should erase attendance in lecture" do
	# 		expect { click_link "remove_attendance_0" }.to change(Attendance, :count).by(-1)
	# 		visit new_group_lecture_attendance_path(group,lecture)
	# 	end

	# 	it { should have_content('#{lecture.attendances.count} Asistentes') }
	# 	it { should have_content("#{group.spots.count} Inscritos") }

	# end

end