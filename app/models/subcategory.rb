class Subcategory < ActiveRecord::Base
	
	belongs_to :category
	has_many :posts
	# validates :name, uniqueness: true

	validates :name, presence: true
	validates :category_id, presence: true

end