class Exercise < ActiveRecord::Base

	before_save :downcase_name
	after_initialize :capitalize_name

	has_many :plans
	has_many :area_relations
	has_many :areas, through: :area_relations, :dependent => :restrict_with_error
	has_many :lectures, through: :plans, :dependent => :restrict_with_error
	validates_presence_of :name, :min_age, :max_age , :objective , :description
	validates :name, length: { maximum: 50 }

	self.per_page = 15

	include PgSearch

	pg_search_scope :search, against: [:name], ignoring: :accents

	def self.text_search(query)
		search(query)
	end

	def full_name
		"#{name}"
	end

	private

		def downcase_name
			self.send("#{:name}=", self.send(:name).downcase) if self.send(:name)
		end

		def capitalize_name
			self.send("#{:name}=", self.send(:name).capitalize) if self.send(:name)
		end

end