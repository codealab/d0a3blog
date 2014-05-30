class ProgramRelation < ActiveRecord::Base
	belongs_to :program
	belongs_to :exercise

	validates :program_id, presence: true
	validates :exercise_id, presence: true
end