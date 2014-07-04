#encoding: UTF-8
class MediaPosts < ActiveRecord::Base

	belongs_to :post 
	belongs_to :media 

	validates_uniqueness_of :post_id, :scope => :media_id

end