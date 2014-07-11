# encoding: UTF-8
class Lecture < ActiveRecord::Base

	after_validation :when_date_is_before_today
	has_many :plans
	has_many :exercises, through: :plans, :dependent => :restrict_with_error
	after_validation :validate_new_date,  on: [ :update ]
	belongs_to :group

	validates_presence_of :date, :group_id
	validates_uniqueness_of :date, :scope => :group_id
	has_many :attendances, :dependent => :restrict_with_error

	validate :invalid_date
	validate :uniqueness_combination_of_date_and_group_id
	# validate :when_date_is_before_today

	def invalid_date
		if self.date < Date.today
			errors.add(:date, "debe ser mayor al día de hoy.")
		end
	end

	def possible_attendances
		self.group.active_children.where("created_at <= ?", self.date)
	end

	private

		def when_date_is_before_today
			lecture_db = Lecture.find(self.id)
			if lecture_db.date < Date.today.beginning_of_day
				errors.add(:base, "No puedes modificar una clase con una fecha menor a hoy.")
			end
		end

		def validate_new_date
			if self.date > Date.today.beginning_of_day
				errors.add(:date, " nueva que ingresaste debe ser mayor al día de hoy.") if (self.date < Date.today)
			end
		end

		def uniqueness_combination_of_date_and_group_id
			other_lectures = self.group.lectures.where(date:self.date.beginning_of_day..self.date.end_of_day)
			if other_lectures.count > 0
				errors.add(:base, "Ya existe una clase en este día.")
			end
		end

end