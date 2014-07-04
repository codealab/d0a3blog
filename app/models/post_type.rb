#encoding: UTF-8
class PostType < ActiveRecord::Base
	
	has_many :categories_post_types
	has_many :categories, through: :categories_post_types
	has_many :posts

end