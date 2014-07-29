# encoding: UTF-8
class GroupsController < ApplicationController
	
	# helper_method :valid_user
	# before_action :correct_user, only: [:edit, :update, :show, :new, :create, :destroy, :delete]
	load_and_authorize_resource except: [:create]
	# check_authorization

	def index
		if params[:filter]
			@groups = Group.where("finish_date <= :start_date", { start_date: Date.today }).paginate( page: params[:page])
		else
			@groups = Group.where("finish_date >= :start_date", { start_date: Date.today }).paginate( page: params[:page])
		end
	end

	def create
		@group = Group.new(group_params)
		if @group.save
			flash[:success] = "Creación Exitosa"
			redirect_to @group
		else
			render 'new'
		end
	end

	def admin
		@group = Group.find(params[:id])
		@lecture = Lecture.new()
		# @lecture = Lecture.new
	end

	def new
		@group = Group.new
	end

	def edit
		@group = Group.find(params[:id])
	end

	def show
		@group = Group.find(params[:id])
		@lecture = @group.lectures.where( "date >= :start_date", { start_date: Date.today }).order('date ASC').first
		@lecture = @group.lectures.where( "date <= :start_date", { start_date: Date.today }).order('date DESC').first if !@lecture
		@lecture = @group.lectures.find(params[:lecture]) if params[:lecture]
	end

	def update
		@group = Group.find(params[:id])
		if @group.update_attributes(group_params)
			flash[:success] = "Actualización Exitosa"
			redirect_to @group
		else
			render 'edit'
		end
	end

	def destroy
		group = Group.find(params[:id])
		group.remove(:current_user=>current_user)
		if !group.have_dependencies? || current_user.admin?
			flash[:success] = "Grupo Borrado Exitosamente"
		else
			flash[:danger] = "El grupo no se puede borrar. Elimina primero todas sus clases y niños inscritos."
		end
		redirect_to groups_path
	end

	def lecture
		@group = Group.find(params[:group_id])
		@lecture = @group.lectures.build(date: params[:date] )
		@lecture.save
	end

	def calendar
		@lecture = Lecture.find(params[:lecture_id])
		@init_time = @lecture.date.to_time
		@lecture.date = "#{params[:new_date].to_date} #{@init_time}".to_datetime
		render :json => @lecture.errors.full_messages if !@lecture.save
	end

	def relations
		puts 'entro a relations'
		@group = Group.find(params[:id])
		@lecture = Lecture.find(params[:lecture_id])
	end

	private

		def group_params
			params.require(:group).permit(:name, :user_id, :assistant_id, :location, :cost, :min_age, :max_age, :init_date, :finish_date)
		end

	protected

	    def correct_user
			redirect_to(:back, notice: "No tienes permitido crear, editar o borrar grupos.") unless valid_user
		end

		def valid_user
			current_user.admin? || current_user.instructor?
		end

end