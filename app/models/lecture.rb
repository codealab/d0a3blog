# encoding: UTF-8
class Lecture < ActiveRecord::Base

	# before_save :invalid_date
	has_many :plans
	has_many :exercises, through: :plans, :dependent => :restrict_with_error
	belongs_to :group

	validates_presence_of :date, :group_id
	validates_uniqueness_of :date, :scope => :group_id
	has_many :attendances, :dependent => :restrict_with_error

	validate :date_cannot_be_out_of_group_period_time
	validate :invalid_date
	#validate :uniqueness_combination_of_date_and_group_id

	def invalid_date
		if self.date.to_date < Date.today.to_date
			errors.add(:date, "debe ser mayor al día de hoy")
		end
	end

	def date_cannot_be_out_of_group_period_time
		if !self.group.blank?
			range = (self.group.init_date..self.group.finish_date)
			errors.add(:date, "que seleccionaste está fuera de la duración del curso") if 
			!date.blank? and !range.include?(date.to_date)
		end
	end

	# def date_cannot_be_out_of_group_period_time
	# 	range = (self.group.init_date..self.group.finish_date)
	# 	errors.add(:date, "La fecha que seleccionaste está fuera de la duración del curso") if 
	# 	!date.blank? and !range.include?(date.to_date)
	# end

	def possible_attendances
		self.group.active_children.where("created_at <= ?", self.date)
	end

	# def uniqueness_combination_of_date_and_group_id
	# 	existing_day = Lecture.where("date LIKE ? AND group_id LIKE ? ", date, group_id).first
	# 	unless existing_day.blank? || existing_day.id == self.id
	# 		errors.add(:base, "La clase en este día ya existe")
	# 	end
	# end

end