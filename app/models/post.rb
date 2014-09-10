#encoding: UTF-8
class Post < ActiveRecord::Base
	
	attr_accessor :attr_modified

	belongs_to :user
	belongs_to :post_type
	has_many :comments

	has_many :post_categories
	has_many :categories, through: :post_categories

	has_many :resources_posts
	has_many :resources, through: :resources_posts

	has_many :post_tags
	has_many :tags, through: :post_tags

	validates :title, presence: true
	validates :user_id, presence: true
	# validates :post_type_id, presence: true

	mount_uploader :cover, ResourceUploader

	paginates_per 10

	def author
		self.user.name
	end

end