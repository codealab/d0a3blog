class Attendance < ActiveRecord::Base
	
	belongs_to :spot
	belongs_to :lecture

	validates_uniqueness_of :spot_id, :scope => :lecture_id
	validates_presence_of :spot_id, :lecture_id
	validates_presence_of :observation, :unless => lambda { self.observation.nil? }

end