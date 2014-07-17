#encoding: UTF-8
class Resource < ActiveRecord::Base

	mount_uploader :url, ResourceUploader #, if :type => 'photo'

	has_many :resources_posts
	has_many :posts, through: :resources_posts

end