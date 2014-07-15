class Category < ActiveRecord::Base

	has_many :categories_post_types
	has_many :post_types, through: :categories_post_types

	belongs_to :parent, :class_name => 'Category'
	has_many :childrens, :class_name => 'Category', :foreign_key => 'parent_id'

	validates :name, uniqueness: true
	validates :name, presence: true

end