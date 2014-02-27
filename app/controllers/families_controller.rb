# encoding: UTF-8
class FamiliesController < ApplicationController
	#include FamiliesHelper

	before_action :signed_in_user
	helper_method :valid_user
	before_action :correct_user, only: [:edit, :update, :new, :create, :destroy, :delete]

	def index
		@families = Family.where(:status=>true).order("name ASC").paginate(page: params[:page])
		if params[:filter]
			@families = Family.all.order("name ASC").paginate(page: params[:page])
		end
	end

	def create
		@family = Family.new(family_params)
		if @family.save
			flash[:success] = "Creación Exitosa"
			redirect_to @family
		else
			render 'new'
		end
	end

	def new
		@family = Family.new
	end

	def edit
		@family = Family.find(params[:id])
	end

	def show
		@family = Family.find(params[:id])
	end

	def status
		@family = Family.find(params[:id])
		@family.toggle!(:status)
		@family.save
	end

	def update
		@family = Family.find(params[:id])
		if @family.update_attributes(family_params)
			flash[:success] = "Actualización Exitosa"
			redirect_to @family
		else
			render 'edit'
		end
	end

	def destroy
		Family.find(params[:id]).destroy
		flash[:success] = "Familia Borrada"
		redirect_to families_path
	end

	private

		def family_params
			params.require(:family).permit(:name)
		end

		def correct_user
			redirect_to(families_path, notice: "No tienes permitido crear, editar o borrar familias.") unless valid_user
		end

		def valid_user
			current_user.admin? || current_user.coordinator? #|| current_user.facilitator?
		end
end