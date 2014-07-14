# encoding: UTF-8
class CoursesController < ApplicationController

  load_and_authorize_resource

  def index
  	@courses = Group.all
  end

  def new
  	@program = Program.find(params[:program_id])
  	@course = Course.new(@program)
  end

  def edit
  end

  def create
  	@program = Program.find(params[:course][:program_id])
  	@course = Course.new(@program)
  	if @course.submit(params[:course])
  		flash[:success] = "Curso creado exitosamente"
  		redirect_to group_path(@course.group)
  	else
  		render 'new'
  	end
  end

end