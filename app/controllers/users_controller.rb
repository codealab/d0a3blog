class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = user.new
	end

	def create
		@user = user.new(user_params)
		if @user.save
			flash[:success] = "El usuario se creó exitosamente"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def show
		@user = user.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(user_params)
		if @user.save
			flash[:success] = 'Usuario actualizado correctamente'
			redirect_to user_path(@user)
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
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin )
	  end

end