class Program < ActiveRecord::Base

	after_create :generate_lessons

	has_many :lessons, :dependent => :restrict_with_error
	has_many :exercises, through: :lessons

	validates_presence_of :name, :min_age, :max_age
	validates_numericality_of :number_of_lessons, :greater_than_or_equal_to => 1, :allow_nil => false

	private

	  def generate_lessons
	  	lessons = self.number_of_lessons.to_i
	  	lessons.times do |lesson|
	  		self.lessons.create( order_day: lesson+1 )
	  	end
	  end

end