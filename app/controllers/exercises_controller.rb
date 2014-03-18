# encoding: UTF-8
class ExercisesController < ApplicationController

	def index
		@exercises = Exercise.all
		@group = Group.find(params[:group_id])
		@lecture = Lecture.find(params[:lecture_id])
	end

	def new
		@exercise = Exercise.new
		@group = Group.find(params[:group_id])
		@lecture = Lecture.find(params[:lecture_id])
	end

	def create
		@exercise = Exercise.new(exercise_params)
		if(@exercise.save)
			flash[:success] = 'Ejercicio creado exitosamente'
			redirect_to groups_path
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
		@group = Group.find(params[:group_id])
		@lecture = Lecture.find(params[:lecture_id])
	end

	def show
		@exercise = Exercise.find(params[:id])
		@group = Group.find(params[:group_id])
		@lecture = Lecture.find(params[:lecture_id])
	end

	def update
		@exercise = Exercise.find(params[:id])
		if @exercise.update_attributes(exercise_params)
			redirect_to group_path(@group)
			flash[:succes] ="Actualización exitosa"
		else
			@exercise.reload
			render 'edit'
		end
	end

	def destroy
		Exercise.find(params[:id]).destroy
		flash[:success] = "Ejercicio borrado"
		@group = Group.find(params[:group_id])
		@lecture = Lecture.find(params[:lecture_id])
		redirect_to group_lecture_path(@group,@lecture)
	end 

	private

	def exercise_params
		params.require(:exercise).permit(:area, :min_age, :max_age, :objective, :description, :material, :music)
    end

end