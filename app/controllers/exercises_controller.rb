# encoding: UTF-8
class ExercisesController < ApplicationController

	def index
		@exercises = Exercise.all.order('id desc').paginate(page: params[:page])
		if params[:group_id] && params[:lecture_id]
			@group = Group.find(params[:group_id])
			@lecture = Lecture.find(params[:lecture_id])
			@exercises = Exercise.where("min_age >= #{@group.min_age} AND min_age<= #{@group.max_age} OR max_age >= #{@group.min_age} AND max_age<= #{@group.max_age}").paginate(page: params[:page])
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
		if(@exercise.save)
			flash[:success] = 'Ejercicio creado exitosamente. En caso de no visualizarlo, verifica la edad mínima y máxima del mismo. Así podrás usarlo dentro de este grupo.'
			areas @exercise
			if params[:exercise][:group_id] && params[:exercise][:lecture_id]
				redirect_to group_lecture_exercises_path(params[:exercise][:group_id],params[:exercise][:lecture_id])
			else
				redirect_to exercises_path
			end
		else
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

	def destroy
		Exercise.find(params[:id]).destroy
		flash[:success] = "Ejercicio borrado"
		if params[:group] && params[:lecture]
			@group = Group.find(params[:group_id])
			@lecture = Lecture.find(params[:lecture_id])
			redirect_to group_lecture_path(@group,@lecture)
		else
			redirect_to exercises_path
		end
	end 

	private

	def exercise_params
		params.require(:exercise).permit(:name, :min_age, :max_age, :objective, :description, :material, :music)
	end

	def areas(exercise)
		exercise.areas.delete_all
		areas = params[:area]
		areas.each { |a| exercise.area_relations.build(area_id:a[0]) if a[1]=='on' }
		exercise.save
	end

end