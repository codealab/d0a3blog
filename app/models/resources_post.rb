#encoding: UTF-8
class ResourcesPost < ActiveRecord::Base

	belongs_to :post 
	belongs_to :resource 

	validates_uniqueness_of :post_id, :scope => :resource_id

end