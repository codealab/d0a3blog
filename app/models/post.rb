#encoding: UTF-8
class Post < ActiveRecord::Base

	belongs_to :user
	belongs_to :post_type

	belongs_to :cover, :class_name => 'media'

	has_many :post_categories
	has_many :categories, through: :post_categories

	has_many :post_tags
	has_many :tags, through: :post_tags

	validates :title, presence: true
	validates :user_id, presence: true

	def author
		self.user.name
	end

end