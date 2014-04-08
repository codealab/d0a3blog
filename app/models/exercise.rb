class Exercise < ActiveRecord::Base

	has_many :plans
	has_many :area_relations
	has_many :areas, through: :area_relations, :dependent => :restrict_with_error
	has_many :lectures, through: :plans, :dependent => :restrict_with_error
	validates_presence_of :name, :min_age, :max_age , :objective , :description
	validates :name, length: { maximum: 50 }

	self.per_page = 15

	def full_name
		"#{name}"
	end

end