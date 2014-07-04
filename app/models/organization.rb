#encoding: UTF-8
class Organization < ActiveRecord::Base

	has_many :users

end