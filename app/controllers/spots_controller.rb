# encoding: UTF-8
class SpotsController < ApplicationController
	
	# helper_method :valid_user
	# before_action :correct_user, only: [:update, :create, :destroy, :new, :index]
	before_action :pasive_family, only: [:update, :edit]
	load_and_authorize_resource

	def index
		@group = Group.find(params[:group_id])
		@spots = @group.spots
	end

	def create
		@group = Group.find(params[:group_id])
		person = Person.find(params[:child_id])
		@spot = @group.spots.build( child_id: person.id )
		@spot.observation = "<p><b>Fecha de inscripción:</b></br>#{ I18n.l Date.today.to_datetime, :format => '%d de %B del %Y'}<p>"
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
		@spot = Spot.find(params[:id])
		@group = Group.find(params[:group_id])
		@child = @spot.child
		@spot.destroy
		# flash[:success] = "Spot borrado"
		# redirect_to groups_path
	end

	def observation
		@spot = Spot.find(params[:id])
		observation = @spot.observation
		if params[:observation]
			@spot.observation = "#{observation} <p><b>Observación</b> (#{I18n.l Date.today.to_datetime, :format => '%d de %B del %Y'})</br> #{params[:observation]}</p>"
			@spot.save
		end
	end

	def deactivated
		@spot = Spot.find(params[:id])
		@group = Group.find(params[:group_id])
		@child = @spot.child
		observation = @spot.observation
		if @spot.deactivated.blank?
			@spot.deactivated = "#{Date.today.to_date}"
			@spot.observation = "#{observation} <p><b>Fecha de Baja:</b></br>#{ I18n.l Date.today.to_datetime, :format => '%d de %B del %Y'}</p>"
		else
			@spot.deactivated = nil
			@spot.observation = "#{observation} <p><b>Fecha de Reinscripción:</b></br>#{ I18n.l Date.today.to_datetime, :format => '%d de %B del %Y'}</p>"
		end
		@spot.save
	end

	def search
		@group = Group.find(params[:group_id])
		@childs = Person.children.text_search(params[:query].downcase)
	end

	private

	def spot_params
      params.permit(:child_id, :group_id)
    end

    def correct_user
		redirect_to(:back, notice: "No tienes permitido crear, editar o borrar grupos.") unless valid_user
	end

	def valid_user
		current_user.admin? || current_user.instructor?
	end

	def pasive_family
		@spot = Spot.find(params[:id])
		@group = Group.find(params[:group_id])
		redirect_to(group_spot_path(@group,@spot)) unless @spot.child.family_relations.first.family.status?
	end

end