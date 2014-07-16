#encoding: UTF-8

class Media < ActiveRecord::Base

	mount_uploader :cover, PhotoUploader #, if :type => 'photo'

	has_many :media_posts
	has_many :posts, through: :media_posts

end