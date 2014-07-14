class FamilyRelation < ActiveRecord::Base

	belongs_to :person
	belongs_to :family

	validates :person_id, presence: true
	validates :family_id, presence: true
	validates_uniqueness_of :family_id, :scope => :person_id

	validate :person_exists

	def person_exists
		errors.add(:person_id, "La persona no existe en la base de datos") if !Person.find(person_id)
	end

end