class Program < ActiveRecord::Base

	# after_create :generate_lectures

	has_many :program_relations
	has_many :exercises, through: :program_relations #, :dependent => :restrict_with_error

	validates_presence_of :name, :min_age, :max_age
	validates_numericality_of :lectures, :greater_than_or_equal_to => 1, :allow_nil => true

	private

	  def generate_lectures
	  	lectures = self.lectures.to_i
	  	lectures.times do |lecture|
	  		self.ProgramRelation.create(lecture:lecture)
	  	end
	  end

end