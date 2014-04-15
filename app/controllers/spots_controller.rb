# encoding: UTF-8
class SpotsController < ApplicationController
	
	helper_method :valid_user
	before_action :correct_user, only: [:update, :create, :destroy, :new, :index]
	before_action :pasive_family, only: [:update, :edit]

	def index
		@group = Group.find(params[:group_id])
		@spots = @group.spots
	end

	def create
		@group = Group.find(params[:group_id])
		person = Person.find(params[:child_id])
		@spot = @group.spots.build( child_id: person.id )
		@group.save
	end

	def new
		@group = Group.find(params[:group_id])
		today = Date.today
		min_weeks = today-(@group.min_age).weeks
		max_weeks = today-(@group.max_age).weeks
		@childs = Person.where(dob: max_weeks..min_weeks)
	end

	def edit
		@group = Group.find(params[:group_id])
		@spot = @group.spots.find(params[:id])
	end

	def show
		@group = Group.find(params[:group_id])
		@spot = Spot.find(params[:id])
	end

	def update
		@group = Group.find(params[:group_id])
		@spot = Spot.find(params[:id])
	    if @spot.update_attributes(spot_params)
	    	flash[:success] = "Actualización Exitosa"
	    	redirect_to @group
	    else
	    	render 'edit'
	    end
	end

	def destroy
		spot = Spot.find(params[:id])
		@group = Group.find(params[:group_id])
		@child = spot.child
		Spot.find(params[:id]).destroy
		# flash[:success] = "Spot borrado"
		# redirect_to groups_path
	end

	def search
		@group = Group.find(params[:group_id])
		@childs = Person.children.text_search(params[:query].downcase)
	end

	private

	def spot_params
      params.require(:spot).permit(:tutor_id)
    end

    def correct_user
		redirect_to(:back, notice: "No tienes permitido crear, editar o borrar grupos.") unless valid_user
	end

	def valid_user
		current_user.admin? || current_user.facilitator?
	end

	def pasive_family
		@spot = Spot.find(params[:id])
		@group = Group.find(params[:group_id])
		redirect_to(group_spot_path(@group,@spot)) unless @spot.child.family_relations.first.family.status?
	end

end