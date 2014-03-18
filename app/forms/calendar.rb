# encoding: UTF-8
class Calendar
	include ActiveModel::Model

	attr_accessor :monday, :tuesday, :wednesday, :thursday, :friday, :monday_hour, :tuesday_hour, :wednesday_hour, :thursday_hour, :friday_hour

	def persisted?
		false
	end

	def initialize(group)
		@calendar = group
	end

	def submit(params)

		no_errors = true
		days = ["monday", "tuesday", "wednesday", "thursday", "friday"]
		days_symbols = [ :monday, :tuesday, :wednesday, :thursday, :friday ]
		days_params = [params[:monday], params[:tuesday], params[:wednesday], params[:thursday], params[:friday]]

		days.each_with_index do |day, index|
			if days_params[index]=="1"
				hour_day = day+"_hour(4i)"
				minute_day = day+"_hour(5i)"

				if !params[hour_day].blank? & !params[minute_day].blank?

					hour = "#{params[hour_day]}:#{params[minute_day]}"
					days = (@calendar.init_date..@calendar.finish_date).to_a.select {|k| index+1==(k.wday) }

					generate_lectures(days,hour)
				else
					errors.add days_symbols[index], "El campo de hora no puede estar vacío"
					no_errors = false
				end
			end
		end

		return no_errors

	end


	def generate_lectures(days,hour)
		no_errors = true
		
		days.each do |day|			
			@calendar.lectures.build({ date: "#{day}+" "#{hour}" })
			if !@calendar.save!
				errors.add :classes, "Ocurrió algún error al generar las clases"
				no_errors = false
			end
		end

		return no_errors
	end

end