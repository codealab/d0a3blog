class Group < ActiveRecord::Base
	before_save :downcase_names
	after_initialize :titleize_names

	belongs_to :user
	has_many :spots, :dependent => :restrict_with_error
	has_many :lectures, :dependent => :restrict_with_error
	has_many :attendances, through: :lectures
	has_many :payments, through: :spots

	validates_presence_of :name, :user_id, :cost, :location, :min_age, :max_age, :init_date, :finish_date
	validates :name, length: { maximum: 50 }
	validates_numericality_of :cost, :greater_than_or_equal_to => 0
	validates :min_age, :numericality => { :greater_than_or_equal_to => 0 }
	validates :max_age, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 240 } #240 is equal to 5 years on weeks

	#Custom Methods
	validate :min_age_cannot_be_greater_than_max_age
	validate :init_date_cannot_be_greater_than_finish_date

	self.per_page = 15

	def facilitador
		self.user.name
	end

	private

		def min_age_cannot_be_greater_than_max_age
	    errors.add(:min_age, "La edad minima es mayor a la maxima") if 
	    !min_age.blank? and !max_age.blank? and min_age > max_age
	  end

	  def init_date_cannot_be_greater_than_finish_date
	    errors.add(:init_date, "La fecha de inicio de curso es mayor a la de fin curso") if 
	    !init_date.blank? and !finish_date.blank? and init_date > finish_date
	  end

	  def downcase_names
	      self.send("#{:name}=", self.send(:name).downcase) if self.send(:name)
	  end

	  def titleize_names
	      self.send("#{:name}=", self.send(:name).titleize) if self.send(:name)
	  end

end