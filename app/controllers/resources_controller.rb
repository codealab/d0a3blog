#encoding: UTF-8
class ResourcesController < ApplicationController

	def index
		@resource = Resource.all.paginate(page: params[:page])
	end
	
	def new
		@resource = Resource.new
	end

	def show
		@resource = Resource.find(params[:id])
	end

	def create
		@resource = Resource.new(resource_params)
		if @resource.save
			if params[:resource][:photo_path].present?
				render :crop
			else
				flash[:success] = "Se creo el multimedia exitosamente"
				redirect_to @resource
			end
		else
			render 'new'
		end
	end

	def edit
		@resource = Resource.find(params[:id])
	end

	def update
		@resource = Resource.find(params[:id])
		@resource.update_attributes(resource_params)
		if @resource.save
			if params[:resource][:photo_path].present?
				render :crop
			else
				flash[:success] = "Multimedia creado exitosamente"
				redirect_to @resource
			end
		else
			render 'edit'
		end
	end

	def destroy
		Resource.find(params[:id]).destroy
		flash[:success] = "Multimedia borrado exitosamente"
		redirect_to resources_path
	end

	private

		def resource_params
			params.require(:resource).permit( :title, :resource_type, :photo_path, :description, :file_url )
		end

end