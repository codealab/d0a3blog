#encoding: UTF-8
class Resource < ActiveRecord::Base

	# mount_uploader :file_url, ResourceUploader, :mount_on => :photo_path
	mount_uploader :photo_path, ResourceUploader

	mount_uploader :photo, PhotoUploader

	has_many :resources_posts
	has_many :posts, through: :resources_posts

end