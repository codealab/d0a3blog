# encoding: UTF-8
require 'date'
class Course

	include ActiveModel::Model
	extend ActiveModel::Naming
	include ActiveModel::Conversion
	include ActiveModel::Validations
	include ActiveView::helpers.sanitize(DatesHelper)
 
	attr_accessor :name, :group, :program, :user_id, :assistant_id, :cost, :location, :init_date, :finish_date, :monday, :tuesday, :wednesday, :thursday, :friday, :monday_hour, :tuesday_hour, :wednesday_hour, :thursday_hour, :friday_hour, :calendar
	validates_presence_of :name, :user_id, :cost, :location, :init_date
	validates_presence_of :monday_hour, :unless => lambda { self.monday.blank? }
	validates_presence_of :tuesday_hour, :unless => lambda { self.tuesday.blank? }
	validates_presence_of :wednesday_hour, :unless => lambda { self.wednesday.blank? }
	validates_presence_of :thursday_hour, :unless => lambda { self.thursday.blank? }
	validates_presence_of :friday_hour, :unless => lambda { self.friday.blank? }

	def persisted?
		false
	end

	def initialize(program)
		@program = program
		# finish_date
	end

	def submit(params)
		self.name = params[:name]
		self.user_id = params[:user_id]
		self.cost = params[:cost]
		self.group = Group.new
		self.program = @program
		#init_date no es atributo nativo de fecha, parseamos en convert_date
		self.init_date = convert_date(params)
		self.location = params[:location]
		self.monday = params[:monday]
		self.tuesday = params[:tuesday]
		self.wednesday = params[:wednesday]
		self.thursday = params[:thursday]
		self.friday = params[:friday]
		#[day]_hours no es atributo nativo de tiempo, parseamos en convert_hour
		self.monday_hour = convert_hour(params,'monday') if self.monday_hour.blank?
		self.tuesday_hour = convert_hour(params,'tuesday') if self.tuesday_hour.blank?
		self.wednesday_hour = convert_hour(params,'wednesday') if self.wednesday_hour.blank?
		self.thursday_hour = convert_hour(params,'thursday') if self.thursday_hour.blank?
		self.friday_hour = convert_hour(params,'friday') if self.friday_hour.blank?

		if valid?
			#si el curso es valido creamos grupo y buscamos fechas para las clases dentro del grupo
			group.update_attributes(name: name, user_id: user_id, cost: cost, min_age: @program.min_age, max_age: @program.max_age, init_date: init_date, location: location )
			find_lectures
			true
		else
			false
		end
	end

	def convert_date(params)
		day = params["init_date(3i)"] if params["init_date(3i)"]
		month = params["init_date(2i)"] if params["init_date(2i)"]
		year = params["init_date(1i)"] if params["init_date(1i)"]
		return "#{day}/#{month}/#{year}".to_date
	end

	def convert_hour(params,day)
		hour = params["#{day}_hour(4i)"]
		minutes = params["#{day}_hour(5i)"]
		return "#{hour}:#{minutes}" if hour != '' && minutes
		false
	end

	def find_lectures
		#inicializar arreglo con días activos
		active_days = []
		active_days<<1 if monday
		active_days<<2 if tuesday
		active_days<<3 if wednesday
		active_days<<4 if thursday
		active_days<<5 if friday
		day_active = active_days.first

		#inicializar horas de días activos
		active_hours = []
		active_hours<<monday_hour if monday
		active_hours<<tuesday_hour if tuesday
		active_hours<<wednesday_hour if wednesday
		active_hours<<thursday_hour if thursday
		active_hours<<friday_hour if friday

		#inicilizar arreglo para almacenar días y horas de clases
		dates = []
		#date_active=inicio de período para realizar busqueda
		#menos un día para prevenir el día seleccionado sea el mismo día para dar la siguiente clase
		date_active = group.init_date-1.day
		#encontrar el valor número del día para realizar búsquedas en el recorrido de semanas
		date = group.init_date.wday
		#finded en falso, para el ciclo while.
		finded = false
		counter = 0

		while counter < active_days.count
   			day_active = active_days[counter]
   			if date<=day_active
   				finded=true
   				counter=active_days.count
   			else
   				counter+=1
   			end
		end
		#Si no se encontró ningún valor menor a igual a los días activos, /
		# el día activo para comenzar a realizar búsquedas es el primer día en el arreglo active_days
		day_active = active_days.first if !finded
		#busqueda de hora, respecto a la misma posición del día seleccionado dentro de sus respectivos arreglos
		day_position = active_days.index(day_active)
		#while de número de clases
		counter = 0

		while dates.count!=@program.number_of_lessons
			hour = active_hours[day_position.to_i]
			#creación de fecha con día y horas encontradas en los arreglos 
			datetime_active = ("#{date_active} #{hour}").to_datetime
			#busqueda de la siguiente clase
			dates << select_next_day(datetime_active,day_active)
			if day_position==active_days.count-1
				day_position=0
			else
				day_position+=1
			end
			day_active = active_days[day_position].to_i
			date_active = dates.last.to_date
		end
		#una vez encontradas todas las clases, generar relación con el grupo
		generate_lectures(dates)
	end

	def select_next_day(date,day_active)
		day = date
		#day>>suma de uno para aumentar intervalo de tiempo
		#day_active>>resta de un día para prevenir el desfaz de suma de días
		day += 1 + (((day_active-1)-day.wday) % 7)
	end

	def generate_lectures(dates)
		#una vez encontradas las fechas, cerramos el período del grupo con la fecha de la última clase
		group.finish_date = dates.last
		group.save

		#una vez guardado el grupo podemos relacionar clases almacenadas en dates
		dates.each_with_index do |d,index|
			dif = Time.now.to_datetime.formatted_offset(true)
			lecture = group.lectures.build({ date: d.to_datetime+6.hours })
			lesson = program.lessons.find_by_order_day( index+1 )
			if group.save
				if lesson
					lesson.exercises.each do |exercise|
						Plan.create({ lecture_id: lecture.id, exercise_id: exercise.id })
					end
				end
			end
		end
	end
end