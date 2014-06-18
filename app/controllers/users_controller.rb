#encoding: UTF-8
class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			if params[:user][:photo].present?
				render :crop
			else
				flash[:success] = "Usuario creado exitosamente"
				redirect_to users_path
			end
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(user_params)
		if @user.save
			if params[:user][:photo].present?
				render :crop
			else
				flash[:success] = "Usuario creado exitosamente"
				redirect_to users_path
			end
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "usuario eliminado exitosamente"
		redirect_to users_path
	end

	private

	  def user_params
		params.require(:user).permit(:name, :email, :password, :photo, :password_confirmation, :administrator, :crop_x, :crop_y, :crop_w, :crop_h )
	  end

end