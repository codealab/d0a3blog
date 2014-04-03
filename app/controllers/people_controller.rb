# encoding: UTF-8
class PeopleController < ApplicationController

	before_action :signed_in_user
	helper_method :valid_user
	helper_method :is_child
	before_action :correct_user, only: [:edit, :update, :new, :create, :destroy, :delete]

	def index
		@people = Person.all.order("name ASC").paginate(page: params[:page])
	end

	def create
		@family = Family.find(params[:family_id])
		@person = @family.family_members.build(persons_params)
		@oldphoto = params[:person][:oldphoto]
		if @family.save  
			flash[:success] = "Creación Exitosa"
			redirect_to @family
		else
			render 'new'
		end
	end

	def new
	   @family = Family.find(params[:family_id])
	   @person = @family.family_members.build
	   @oldphoto = @person.photo_url
	end

	def edit
		@family = Family.find(params[:family_id])
		@person = @family.family_members.find(params[:id])
		@oldphoto = @person.photo_url
	end

	def show
		@person = Person.find(params[:id])
	end

	def update
		@family = Family.find(params[:family_id])
		@person = Person.find(params[:id])
		@oldphoto = params[:person][:oldphoto]
	    if @person.update_attributes(persons_params)
		    if @person.family_roll=='Otro'
				@person.update_attributes(family_roll:params[:person][:other])
			end
	    	flash[:success] = "Actualización Exitosa"
	    	redirect_to @family
	    else
	    	render 'edit'
	    end
	end

	def destroy
		@family = Family.find(params[:family_id])
		Person.find(params[:id]).destroy
    	flash[:success] = "Miembro de Familia Borrado"
    	redirect_to @family
	end

	private

		def persons_params
			params.require(:person).permit(:name, :first_last_name, :second_last_name, :sex, :dob, :family_roll, :photo)
		end

		protected

		def correct_user
			redirect_to(families_path, notice: "No tienes permitido crear, editar o borrar familias.") unless valid_user
		end

		def valid_user
			current_user.admin? || current_user.coordinator?
		end

		def is_child
			((Date.today.to_date - @person.dob.to_date)/365).to_i < 5 ? true:false
		end

end