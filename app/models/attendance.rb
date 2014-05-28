# encoding: UTF-8
class Attendance < ActiveRecord::Base
	
	belongs_to :spot
	belongs_to :lecture

	validates_uniqueness_of :spot_id, :scope => :lecture_id
	validates_presence_of :spot_id, :lecture_id
	validates_presence_of :observation, :unless => lambda { self.observation.nil? }

	validate :lecture_date

	def lecture_date
		errors.add(:lecture, "La clase aún no ha comenzado, no se puede crear esta asistencia") if self.lecture.date > Date.tomorrow.to_date
	end

end