#encoding: UTF-8
class Media < ActiveRecord::Base

	has_many :media_posts
	has_many :posts, through: :media_posts

end