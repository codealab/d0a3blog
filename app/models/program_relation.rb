#encoding: UTF-8
class ProgramRelation < ActiveRecord::Base
	
	belongs_to :program
	belongs_to :exercise

	validates :program_id, presence: true
	validates :exercise_id, presence: true

	validate :field_uniqueness

	private

	  def field_uniqueness
		existing_record = ProgramRelation.where("exercise_id = ? AND program_id = ? AND lecture = ?", exercise_id, program_id, lecture ).first
		unless existing_record.blank? || (existing_record.id == self.id )
			errors.add(:base, "Un ejercicio no puede estar más de una vez en el mismo programa y clase.")
		end
	  end

end