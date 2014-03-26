class Payment < ActiveRecord::Base
	belongs_to :spot
	validates_presence_of :amount, :date, :spot_id
	self.per_page = 15
end