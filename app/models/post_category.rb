#encoding: UTF-8
class PostCategory < ActiveRecord::Base

	belongs_to :category
	belongs_to :post

	validates_uniqueness_of :category_id, :scope => :post_id

end