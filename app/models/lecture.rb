# encoding: UTF-8
class Lecture < ActiveRecord::Base

	attr_accessor :skip_validation

	after_validation :when_date_is_before_today,  on: [ :update ]
	after_save :increase_decrease_duration_group, :if => :date
	has_many :plans
	has_many :exercises, through: :plans, :dependent => :delete_all
	after_validation :validate_new_date, :if => :date

	before_destroy :adjust_finish_date_group
	belongs_to :group

	validates_presence_of :date, :group_id
	validates_uniqueness_of :date, :scope => :group_id
	has_many :attendances, :dependent => :delete_all

	validate :invalid_date, :if => :date
	validate :uniqueness_combination_of_date_and_group_id, :if => :group
	# validate :when_date_is_before_today

	def invalid_date
		if self.date < Date.today && !self.skip_validation
			errors.add(:date, "debe ser mayor al día de hoy.")
		end
	end

	def possible_attendances
		self.group.active_children.where("created_at <= ?", self.date)
	end

	private

		def adjust_finish_date_group
			if self.group.lectures.order('date ASC').last.id == self.id
				self.group.finish_date = self.date.to_date
				self.group.save
			end
		end

		def increase_decrease_duration_group
			lectures = self.group.lectures.order('date ASC')
			if lectures.count > 1
				self.group.finish_date = lectures.last.date.to_date if (self.group.finish_date < lectures.last.date.to_date)
				self.group.init_date = lectures.first.date.to_date if (self.group.init_date > lectures.first.date.to_date)
			end
			self.group.save
		end

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
			if self.date
				existing_record = self.group.lectures.where( date: self.date.beginning_of_day..self.date.end_of_day).first
				errors.add(:base, "Ya existe una clase en este día.") unless existing_record.blank? || existing_record.id == self.id
			end
		end

end