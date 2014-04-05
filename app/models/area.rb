class Area < ActiveRecord::Base
	has_many :area_relations
	has_many :exercises, through: :area_relations
	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
end