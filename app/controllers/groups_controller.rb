# encoding: UTF-8
class GroupsController < ApplicationController
	#include GroupsHelper
	#skip_before_action :correct_user, only: [:index]
	
	helper_method :valid_user
	before_action :correct_user, only: [:edit, :update, :new, :create, :destroy, :delete]

	def index
		@groups = Group.all
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
		  params["group"]["name"].downcase!
      params.require(:group).permit(:name, :user_id, :location, :cost, :min_age, :max_age, :init_date, :finish_date)
    end

    def correct_user
			redirect_to(groups_path, notice: "No tienes permitido crear, editar o borrar grupos.") unless valid_user
		end

		def valid_user
			current_user.admin? || current_user.facilitator?
		end

end
