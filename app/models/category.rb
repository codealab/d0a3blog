class Category < ActiveRecord::Base

	has_many :categories_post_types
	has_many :categories, through: :categories_post_types
	has_many :posts, through: :categories_post_types

	validates :name, uniqueness: true
	validates :name, presence: true

end