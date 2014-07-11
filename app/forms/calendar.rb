# encoding: UTF-8
class Calendar
	include ActiveModel::Model
	extend ActiveModel::Naming
	include ActiveModel::Conversion
	include ActiveModel::Validations

	attr_accessor :monday, :tuesday, :wednesday, :thursday, :friday, :monday_hour, :tuesday_hour, :wednesday_hour, :thursday_hour, :friday_hour, :calendar

	validates_presence_of :monday_hour, :unless => lambda { self.monday.blank? }
	validates_presence_of :tuesday_hour, :unless => lambda { self.tuesday.blank? }
	validates_presence_of :wednesday_hour, :unless => lambda { self.wednesday.blank? }
	validates_presence_of :thursday_hour, :unless => lambda { self.thursday.blank? }
	validates_presence_of :friday_hour, :unless => lambda { self.friday.blank? }

	def persisted?
		false
	end

	def initialize(group)
		@group = group
	end

	def submit(params)

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
			select_days(1,self.monday_hour) if self.monday
			select_days(2,self.tuesday_hour) if self.tuesday
			select_days(3,self.wednesday_hour) if self.wednesday
			select_days(4,self.thursday_hour) if self.thursday
			select_days(5,self.friday_hour) if self.friday
			true
		else
			false
		end

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

	def select_days(day,hour)
		days = (@group.init_date..@group.finish_date).to_a.select { |k| day==(k.wday) }
		generate_lectures(days,hour)
	end

	def generate_lectures(days,hour)
		days.each do |day|
			@group.lectures.build({ date: "#{day}+" "#{hour}" })
			@group.save
		end
	end

end