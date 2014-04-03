class Payment < ActiveRecord::Base
	before_save :update_balance
	before_save { |payment| payment.group_id = self.spot.group_id }
	belongs_to :spot
	belongs_to :group
	validates_presence_of :amount, :date, :spot_id
	self.per_page = 15

	def update_balance
		self.spot.balance = ((self.spot.balance).to_i-(self.amount).to_i)
		self.spot.save
	end
end