# encoding: UTF-8
class Payment < ActiveRecord::Base

	before_save :update_balance
	before_save { |payment| payment.group_id = self.spot.group_id }
	belongs_to :spot
	belongs_to :group
	validates_presence_of :amount, :date, :spot_id
	self.per_page = 15

	#custom methods
	
	validate :invalid_payment

	def update_balance
		self.spot.balance = ((self.spot.balance).to_i-(self.amount).to_i)
		self.spot.save
	end

	def invalid_payment
		if self.spot && self.date
			errors.add(:date, "debe ser mayor a la fecha de inscripción #{ I18n.l self.spot.created_at, :format => '%d de %B del %Y'}") if self.date.to_date < self.spot.created_at.to_date
			errors.add(:date, "debe ser menor al día de mañana") if self.date.to_date > Date.today.to_date
		end
	end

end