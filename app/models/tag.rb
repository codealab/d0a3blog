#encoding: UTF-8
class Tag < ActiveRecord::Base

	before_save :remove_spaces

	has_many :post_tags
	has_many :posts, through: :post_tags

	validates :name, presence: true
	validates :name, uniqueness: true

	private

		def remove_spaces
			self.name = self.name.downcase.gsub(" ","")
		end
end