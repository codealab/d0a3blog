# encoding: UTF-8
class ExercisesController < ApplicationController

	# helper_method :valid_user
	# before_action :correct_user, only: [:edit, :update, :show, :new, :create, :destroy, :delete, :index]
	load_and_authorize_resource

	def index
		@exercises = Exercise.all.order('id desc').paginate(page: params[:page])
		@group = Group.find(params[:group_id]) if params[:group_id]
		@lecture = Lecture.find(params[:lecture_id]) if params[:lecture_id]
		if @group && @lecture
			@exercises = Exercise.where("min_age <= #{@group.max_age} AND max_age>= #{@group.min_age}").paginate(page: params[:page])
		end
	end

	def new
		@exercise = Exercise.new
		if params[:group_id] && params[:lecture_id]
			@group = Group.find(params[:group_id])
			@lecture = Lecture.find(params[:lecture_id])
		end
	end

	def create
		@exercise = Exercise.new(exercise_params)
		if check_areas
			if(@exercise.save)
				if params[:group_id]
					if in_range
						flash[:success] = 'Ejercicio creado exitosamente.'
					else
						flash[:success] = 'El Ejercicio ha sido creado exitosamente. Pero está fuera del rango del grupo.'
					end
					redirect_to group_lecture_exercises_path(params[:exercise][:group_id],params[:exercise][:lecture_id])
				else
					redirect_to exercises_path
					flash[:success] = 'Ejercicio creado exitosamente.'
				end
			else
				render 'new'
			end
		else
			flash[:danger] ="El ejercicio debe contener al menos un área"
			@exercise.valid?	
			render 'new'
		end
	end

	def status
		@lecture = Lecture.find(params[:lecture_id])
		@exercise = Exercise.find(params[:id])
		if @exercise.lectures.include?(@lecture)
			Plan.find_by_lecture_id_and_exercise_id(params[:lecture_id],params[:id]).destroy
		else
			Plan.create({ lecture_id: params[:lecture_id], exercise_id: params[:id] })
		end
	end

	def edit
		@exercise = Exercise.find(params[:id])
		if params[:group_id] && params[:lecture_id]
			@group = Group.find(params[:group_id])
			@lecture = Lecture.find(params[:lecture_id])
		end
	end

	def show
		@exercise = Exercise.find(params[:id])
		if params[:group_id] && params[:lecture_id]
			@group = Group.find(params[:group_id])
			@lecture = Lecture.find(params[:lecture_id])
		end
	end

	def update
		@exercise = Exercise.find(params[:id])
		areas @exercise
		if @exercise.update_attributes(exercise_params)
			redirect_to group_path(@group)
			flash[:success] ="Actualización exitosa"
		else
			@exercise.reload
			render 'edit'
		end
	end

	def search
		@group = Group.find(params[:group_id]) if params[:group_id]
		@lecture = Lecture.find(params[:lecture_id]) if params[:lecture_id]
		init = params[:init][0].blank? ? nil:params[:init][0]
		ended = params[:ended][0].blank? ? nil:params[:ended][0]
		name = params[:name].blank? ? nil:params[:name]
		area = params[:area_id].blank? ? nil:params[:area_id]

		if init || ended || name || area
			@area = Area.find_by_id(area) if area
			@exercises = @area ? (@area.exercises):(Exercise.all)

			if init && ended
				@exercises = @exercises.where("min_age >= #{init} AND max_age <= #{ended}")
			elsif init && !ended
			 	@exercises = @exercises.where("min_age >= #{init}")
			elsif !init && ended
				@exercises = @exercises.where("max_age <= #{ended}")
			end
			@exercises = @exercises.text_search(name) if name
		else
			@exercises = []
			flash.now[:notice] = "Debes de llenar al menos un campo en la búsqueda"
		end

	end

	def destroy
		@exercise = Exercise.find(params[:id])
		if @exercise.can_destroy?
			@exercise.destroy
			flash[:success] = "Ejercicio borrado"
			if params[:group] && params[:lecture]
				@group = Group.find(params[:group_id])
				@lecture = Lecture.find(params[:lecture_id])
				redirect_to group_lecture_path(@group,@lecture)
			else
				redirect_to exercises_path
			end
		else
			redirect_to(:back, notice: "Este ejercicio está asignado a una o varias clases. No puede llevarse a cabo esta acción.")
		end
	end 

	private

		def exercise_params
			params.require(:exercise).permit(:name, :min_age, :max_age, :objective, :description, :material, :music)
		end


		def in_range
			(@exercise.min_age <= @exercise.group.max_age) and (@exercise.group.min_age <= @exercise.max_age)
		end

		def check_areas
			checked = false
			if params[:area]
				params[:area].each do |a|
					checked = true if a[1]=='on'
				end
			end
			checked
		end

		def areas(exercise)
			exercise.areas.delete_all
			if params[:area]
				areas = params[:area]
				areas.each { |a| exercise.area_relations.build(area_id:a[0]) if a[1]=='on' }
				exercise.save
			end
		end

		def correct_user
			redirect_to(root_path, notice: "No tienes permitido crear, editar o borrar ejercicios.") unless valid_user
		end

		# def valid_user
		# 	current_user.admin? || current_user.instructor?
		# end

end