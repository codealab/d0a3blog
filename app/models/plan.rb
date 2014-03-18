class Plan < ActiveRecord::Base
	belongs_to :lecture
	belongs_to :exercise
	validates_uniqueness_of :lecture_id, :scope => :exercise_id
	validates_presence_of :exercise_id, :lecture_id
end