class Spot < ActiveRecord::Base
	after_create :group_balance
	belongs_to :group
	belongs_to :child, :class_name => 'Person'
	belongs_to :tutor, :class_name => 'Person'
	has_many :payments, :dependent => :restrict_with_error
	validates_uniqueness_of :child_id, :scope => :group_id
	validates_presence_of :group_id, :child_id, :tutor_id

	def group_balance
		self.balance = self.group.cost
		self.save
	end
end 