class Post < ActiveRecord::Base

	belongs_to :subcategory
	belongs_to :user
	has_many :post_tags
	has_many :tags, :through => :post_tags

	mount_uploader :cover, PhotoUploader

	validates :title, presence: true
	validates :user_id, presence: true
	validates :subcategory_id, presence: true

	def category
		self.subcategory.category.name
	end

	def author
		self.user.name
	end

end