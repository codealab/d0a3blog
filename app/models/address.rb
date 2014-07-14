class Address < ActiveRecord::Base
	belongs_to :family

	validates_presence_of :calle, :num_ext, :ciudad, :estado, :pais

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX }

end
