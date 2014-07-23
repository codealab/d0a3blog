#encoding: UTF-8
class Resource < ActiveRecord::Base

	# before_save :thumb_resource
	# mount_uploader :file_url, ResourceUploader, :mount_on => :photo_path

	after_create :delete_original_file

	attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

	mount_uploader :photo_path, ResourceUploader
	after_update :crop_resource

	paginates_per 10

	has_many :resources_posts
	has_many :posts, through: :resources_posts

	validates :resource_type, presence: true

	# private

	def delete_original_file
	  File.delete self.original_file_path if File.exists? self.original_file_path
	end

	# def thumb_resource
	# 	case self.resource_type
	# 	when 'Foto'
	# 		puts "es foto"
	# 		self.file_url = self.photo_path_url(:thumb)
	# 	when 'Video'
	# 		puts "es video"
	# 		thumb = self.file_url.split('watch?v=')
	# 		self.photo_path = "http://img.youtube.com/vi/#{thumb[1]}/2.jpg"
	# 	when 'Audio'
	# 		puts "es audio"
	# 		self.photo_path = "/assets/audio_thumb.png"
	# 	end
	# end

	def crop_resource
		photo_path.recreate_versions! if crop_x.present?
	end

end