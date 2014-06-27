class Spot < ActiveRecord::Base

	after_create :group_balance
	after_create :assign_tutor

	belongs_to :group
	belongs_to :child, :class_name => 'Person'
	belongs_to :tutor, :class_name => 'Person'
	has_many :payments, :dependent => :restrict_with_error
	has_many :lectures, through: :group
	#has_many :attendances, through: :lectures
	has_many :attendances, :dependent => :restrict_with_error

	validates_uniqueness_of :child_id, :scope => :group_id
	validates_presence_of :group_id, :child_id

	def group_balance
		self.balance = self.group.cost
		self.save
	end

	def child_name
		[child.name,child.first_last_name,child.second_last_name].join(" ")
	end

	def tutor_name
		[tutor.name,tutor.first_last_name,tutor.second_last_name].join(" ")
	end

	def assign_tutor
		if self.child.family_relations.empty?
			errors.add(:child, "no pertenece a ninguna familia")
		else
			self.tutor_id = self.child.family_relations.first.family.responsible_id
			self.save
		end
	end

end