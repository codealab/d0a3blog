class Payment < ActiveRecord::Base
	before_save { |payment| payment.group_id = self.spot.group_id }
	belongs_to :spot
	belongs_to :group
	validates_presence_of :amount, :date, :spot_id
	self.per_page = 15
end