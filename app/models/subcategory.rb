class Subcategory < ActiveRecord::Base
	
	belongs_to :category
	has_many :posts
	# validates :name, uniqueness: true

end