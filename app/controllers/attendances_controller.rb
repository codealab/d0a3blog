# encoding: UTF-8
class AttendancesController < ApplicationController

	helper_method :valid_user
	before_action :correct_user, only: [:create, :destroy]

	def create
		@lecture = Lecture.find(params[:lecture_id])
		@attendance = @lecture.attendances.build(attendance_params)
		@lecture.save
	end

	def new
		@group = Group.find(params[:group_id])
		@lecture = Lecture.find(params[:lecture_id])
	end

	def destroy
		@lecture = Lecture.find(params[:lecture_id])
		@attendance = Attendance.find(params[:id])
		@child = @attendance.person
		@attendance.destroy
		flash[:success] = "Asistencia eliminada"
	end

	def observation
		@attendance = Attendance.find(params[:id])
		@attendance.observation = params[:observation]
		@attendance.save
	end

	private

	def attendance_params
		params.permit( :person_id, :lecture_id )
	end

	def correct_user
		redirect_to(:back, notice: "No tienes permitido crear, editar o borrar grupos.") unless valid_user
	end

	def valid_user
		current_user.admin? || current_user.facilitator?
	end

end