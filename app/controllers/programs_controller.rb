# encoding: UTF-8
class ProgramsController < ApplicationController

  def index
    @programs = Program.all.order("id ASC").paginate(page: params[:page])
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.new(program_params)
    if @program.save
      flash[:success] = 'Creación exitosa'
      redirect_to @program
    else
      render 'new'
    end
  end

  def show
    @program = Program.find(params[:id])
  end

  def edit
    @program = Program.find(params[:id])
  end

  def update
    @program = Program.find(params[:id])
    if @program.update_attributes(program_params)
      flash[:success] = "Actualización exitosa"
      redirect_to @program
    else
      render 'edit'
    end
  end

  def destroy
    flash[:success] = 'Programa borrado'
    Program.find(params[:id]).destroy
    redirect_to programs_path
  end

  def exercises
    @program = Program.find(params[:id])
    @lecture = params[:lecture_id]
    @exercises = Exercise.where("min_age <= #{@program.max_age} AND max_age>= #{@program.min_age}")
  end

  def relation
    @program = Program.find(params[:id])
    @exercise = Exercise.find(params[:exercise_id])
    @lecture = params[:lecture_id]
    @program.program_relations.create(lecture: @lecture, exercise_id: @exercise.id )
  end

  private

    def program_params
      params.require(:program).permit(:min_age, :max_age, :lectures, :name, :description )
    end

end