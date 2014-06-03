# encoding: UTF-8
class Course

	include ActiveModel::Model
	extend ActiveModel::Naming
	include ActiveModel::Conversion
	include ActiveModel::Validations

	attr_accessor :name, :user_id, :assistant_id, :cost, :location, :init_date, :monday, :tuesday, :wednesday, :thursday, :friday, :monday_hour, :tuesday_hour, :wednesday_hour, :thursday_hour, :friday_hour, :calendar
	validates_presence_of :name, :user_id, :cost, :location, :init_date
	validates_presence_of :monday_hour, :unless => lambda { self.monday.blank? }
	validates_presence_of :tuesday_hour, :unless => lambda { self.tuesday.blank? }
	validates_presence_of :wednesday_hour, :unless => lambda { self.wednesday.blank? }
	validates_presence_of :thursday_hour, :unless => lambda { self.thursday.blank? }
	validates_presence_of :friday_hour, :unless => lambda { self.friday.blank? }

	def persisted?
		false
	end

	def initialize(course)
		@course = course
	end

	def submit
		self.monday = params[:monday]
		self.monday_hour = convert_date(params,'monday') if self.monday_hour.blank?
		self.tuesday = params[:tuesday]
		self.tuesday_hour = convert_date(params,'tuesday') if self.tuesday_hour.blank?
		self.wednesday = params[:wednesday]
		self.wednesday_hour = convert_date(params,'wednesday') if self.wednesday_hour.blank?
		self.thursday = params[:thursday]
		self.thursday_hour = convert_date(params,'thursday') if self.thursday_hour.blank?
		self.friday = params[:friday]
		self.friday_hour = convert_date(params,'friday') if self.friday_hour.blank?
		if valid?
			true
		else
			false
		end
	end

	def submit(params)

	end

	def convert_date(params,day)
		hour = params["#{day}_hour(4i)"]
		minutes = params["#{day}_hour(5i)"]
		if hour != '' && minutes
			return "#{hour}:#{minutes}"
		else
			return false
		end
	end

end