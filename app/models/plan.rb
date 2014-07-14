class Plan < ActiveRecord::Base
	
	before_create :materials
	belongs_to :lecture
	belongs_to :exercise
	validates_uniqueness_of :lecture_id, :scope => :exercise_id
	validates_presence_of :exercise_id, :lecture_id

  private

	def materials
		self.material = self.exercise.material if !self.exercise.material.blank?
		self.music = self.exercise.music if !self.exercise.music.blank?
	end

end