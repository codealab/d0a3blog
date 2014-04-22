# encoding: UTF-8
class CalendarsController < ApplicationController
	
	helper_method :valid_user
	before_action :correct_user, only: [:edit, :update, :new, :create, :destroy, :delete]

	def index
		@group = Group.find(params[:calendar][:group_id])
	end

	def new
		@group = Group.find(params[:group_id])
		@calendar = Calendar.new(@group)
	end

	def create
		@group = Group.find(params[:calendar][:group_id])
		@calendar = Calendar.new(@group)
		if @calendar.submit(params[:calendar])
			flash[:success] = 'El calendario de clases se ha creado exitosamente'
			redirect_to group_path(@group)
		else
			render 'new'
		end
	end

	def show
		@group = Group.find(params[:group_id])
	end

	private

    def correct_user
		redirect_to(groups_path, notice: "No tienes permitido crear, editar o borrar grupos.") unless valid_user
	end

	def valid_user
		current_user.admin? || current_user.instructor?
	end

end
