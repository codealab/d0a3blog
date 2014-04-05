class AreaRelation < ActiveRecord::Base
	belongs_to :area
	belongs_to :exercise
	validates_uniqueness_of :area_id, :scope => :exercise_id
	validates_presence_of :exercise_id, :area_id
end