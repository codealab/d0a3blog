# encoding: UTF-8
class ProgramRelationsController < ApplicationController
	
	# load_and_authorize_resource

	def index
		@program = Program.find(params[:id])
		@program_relations = Program.program_relations
	end

	def create
		@lesson = Lesson.find(params[:lesson_id])
	    @program = @lesson.program
    	@exercise = Exercise.find(params[:exercise_id])
    	@relation_exists = @lesson.program_relations.where(exercise_id:@exercise.id).first
    	if @relation_exists
    		@relation_exists.destroy
    	else
    		@program_relation = @lesson.program_relations.create(exercise_id: @exercise.id )
    	end
	end

	def new
	    @lesson = Lesson.find(params[:lesson_id])
	    @program = @lesson.program
	    @exercises = Exercise.where("min_age <= #{@program.max_age} AND max_age>= #{@program.min_age}").order('id desc').paginate(page: params[:page])
	end

	def edit
		@program_relation = ProgramRelation.find(params[:id])
		@program = @program_relation.program
	end

	def show	
		@program = Program.find(params[:id])
	    @lesson = @program.lessons.find_by_id(params[:lesson_id])
	end

	def update
		@program_relation = ProgramRelation.find(params[:id])
	end

	def destroy
		@program_relation = ProgramRelation.find(params[:id])
		@program = @program_relation.program
		@exercise = @program_relation.exercise
		@program_relation.destroy
	end

	def objective
		@lesson = Lesson.find(params[:id])
		@lesson.objective = params[:objective]
		@lesson.save
	end

	def search
		@lesson = Lesson.find(params[:lesson_id])
	    @program = @lesson.program

		init = params[:init][0].blank? ? nil:params[:init][0]
		ended = params[:ended][0].blank? ? nil:params[:ended][0]
		name = params[:name].blank? ? nil:params[:name]
		area = params[:area_id].blank? ? nil:params[:area_id]

		if init || ended || name || area
			@area = Area.find_by_id(area) if area
			@exercises = @area ? (@area.exercises):(Exercise.all)

			if init && ended
				@exercises = @exercises.where("min_age <= #{ended} AND max_age >= #{init}")
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

	private

	  def program_relation_params
		params.permit(:program_id, :exercise_id, :lecture, :objective)
	  end

end