#encoding: UTF-8
class CategoriesPostType < ActiveRecord::Base

	belongs_to :category
	belongs_to :post_type

	validates_uniqueness_of :category_id, :scope => :post_type_id

end