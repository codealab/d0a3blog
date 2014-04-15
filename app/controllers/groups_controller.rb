# encoding: UTF-8
class GroupsController < ApplicationController
	
	helper_method :valid_user
	before_action :correct_user, only: [:edit, :update, :show, :new, :create, :destroy, :delete]

	def index
		if params[:filter]
			@groups = Group.where("finish_date <= :start_date", { start_date: Date.today }).paginate(page: params[:page])
		else
			@groups = Group.where("finish_date >= :start_date", { start_date: Date.today }).paginate(page: params[:page])
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

	def new
		@group = Group.new
	end

	def edit
		@group = Group.find(params[:id])
	end

	def show
		@group = Group.find(params[:id])
		@lecture = @group.lectures.where( "date >= :start_date", { start_date: Date.today }).order('date ASC').first
		if !@lecture
			@lecture = @group.lectures.where( "date <= :start_date", { start_date: Date.today }).order('date DESC').first
		end
		if params[:lecture]
			@lecture = @group.lectures.find(params[:lecture])
		end
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
		flash[:success] = "Grupo Borrado"
		group = Group.find(params[:id])
		group.destroy
		redirect_to groups_path
	end

	private

	def group_params
      params.require(:group).permit(:name, :user_id, :location, :cost, :min_age, :max_age, :init_date, :finish_date)
    end

    protected

    def correct_user
		redirect_to(:back, notice: "No tienes permitido crear, editar o borrar grupos.") unless valid_user
	end

	def valid_user
		current_user.admin? || current_user.facilitator?
	end

end
