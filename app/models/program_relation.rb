#encoding: UTF-8
class ProgramRelation < ActiveRecord::Base
	
	belongs_to :lesson
	belongs_to :exercise

	validates_uniqueness_of :lesson_id, :scope => :exercise_id
	validates_presence_of :exercise_id, :lesson_id

end