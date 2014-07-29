# encoding: UTF-8
class LecturesController < ApplicationController

	load_and_authorize_resource

	def index
		@lectures = Lecture.all
	end

	def create
		@group = Group.find(params[:group_id])
		@lecture = @group.lectures.build(lecture_params)
		@lecture.skip_validation = current_user.admin?
		if @group.save
			flash[:success] = "Clase creada exitosamente"
			redirect_to @group
		else
			render 'new'
		end
	end

	def new
	   @group = Group.find(params[:group_id])
	   @lecture = @group.lectures.build
	end

	def objective
		@lecture = Lecture.find(params[:id])
		@lecture.objective = params[:objective]
		@lecture.save
	end

	def edit
		@group = Group.find(params[:group_id])
		@lecture = @group.lectures.find(params[:id])
	end

	def show
		@lecture = Lecture.find(params[:id])
		@group = @lecture.group
	end

	def update
		@group = Group.find(params[:group_id])
		@lecture = Lecture.find(params[:id])
		if @lecture.update_attributes(lecture_params)
			flash[:success] = "Actualización Exitosa"
			redirect_to @group
		else
			render 'edit'
		end
	end

	def observation
		@lecture = Lecture.find(params[:id])
		@lecture.observation = params[:observation]
		@lecture.save
	end

	def destroy
		@lecture = Lecture.find(params[:id])
		@lecture.remove(:current_user => current_user)
		if !@lecture.have_dependencies? || current_user.admin?
			flash[:success] = "Clase Borrada Exitosamente"
		else
			flash[:danger] = "La clase no se puede borrar. Elimina primero todos sus ejercicios relacionados."
		end
    	flash[:success] = "Clase borrada"
    	redirect_to :back
	end

	private

		def lecture_params
			params.require(:lecture).permit( :date, :group_id, :observation, :objective )
		end

end