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
		let(:member) { FactoryGirl.create(:person) }
		before { visit person_path(member) }
		it { should have_title(member.name.titleize) }
	end

end