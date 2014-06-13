# encoding: UTF-8
require 'json'

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
    if params[:order_day]
      @lesson = @program.lessons.find_by(params[:order_day])
    else
      @lesson = @program.lessons.order('order_day ASC').first
    end
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

  def lecture
    @program = Program.find(params[:id])
    @program.reload
    @program.number_of_lessons = @program.number_of_lessons
    lessons = @program.lessons.count
    @program.number_of_lessons=lessons+1
    @lesson = @program.lessons.build(:order_day=>"#{@program.number_of_lessons}")
    @program.save
  end

  def reorder

    actives = params[:actives]
    deleted = params[:deleted]
    @program = Program.find(params[:id])

    if deleted
      @deletes = @program.lessons.find(deleted)
      @deletes.each { |e| e.destroy }
    end

    actives.each_with_index do |active,index|
      @lesson = @program.lessons.find_by_id(active)
      if @lesson
        @lesson.order_day = index+1
        @lesson.save
      end
    end
    @program.number_of_lessons=actives.count
    @program.save
  end

  def destroy
    flash[:success] = 'Programa borrado'
    Program.find(params[:id]).destroy
    redirect_to programs_path
  end

  private

    def program_params
      params.require(:program).permit(:min_age, :max_age, :number_of_lessons, :name, :description )
    end

end