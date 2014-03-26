class Exercise < ActiveRecord::Base
	has_many :plans
	has_many :lectures, through: :plans, :dependent => :restrict_with_error
	validates_presence_of :name, :area, :min_age, :max_age , :objective , :description
	validates :area, length: { maximum: 50 }
	validates :name, length: { maximum: 50 }

	self.per_page = 15

	def full_name
		"#{ area } #{[min_age,max_age].join('-')}"
	end

end