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
		@person = Person.new(person_params)
		if is_adult
			@family = Family.new(name:(params[:family][:name]))			
			if @family.save
				@person = @family.family_members.build(person_params)
				if @family.save
					@family.update_attributes(responsible_id:@person.id)
					if @person.family_roll=='Otro'
						@person.update_attributes(family_roll:params[:person][:other])
					end
					if params[:person][:photo].present?
						render :crop
					else
						flash.now[:success] = "Familia y responsable creados exitosamente"
						redirect_to @family
					end
				else
					render 'new'
				end
			end
		else
			flash.now[:danger] = "El responsable de familia debe ser mayor de edad"
			render 'new'
		end
	end

	def new
		@person = Person.new
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
			if params[:person]
				render :crop if params[:person][:photo].present?
			else
				flash[:success] = "Actualización Exitosa"
				redirect_to @family
			end
		else
			render 'edit'
		end
	end

	def destroy
		family = Family.find(params[:id])
		Person.find(family.responsible_id).destroy
		family.destroy
		flash[:success] = "Familia Borrada"
		redirect_to families_path
	end

	private

		def family_params
			params.require(:family).permit(:name, :responsible_id)
		end

		def person_params
			params.require(:person).permit(:name, :first_last_name, :second_last_name, :sex, :dob, :family_roll, :photo, :crop_x, :crop_y, :crop_w, :crop_h )
		end	

		def correct_user
			redirect_to(families_path, notice: "No tienes permitido crear, editar o borrar familias.") unless valid_user
		end

		def valid_user
			current_user.admin? || current_user.coordinator? #|| current_user.facilitator?
		end

		def is_adult
			((Date.today.to_date - @person.dob.to_date)/365).to_i > 18 ? true:false
		end
end