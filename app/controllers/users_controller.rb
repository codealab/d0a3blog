# encoding: UTF-8
class UsersController < ApplicationController
  
  skip_before_action :user_visor, only: [:edit, :update]

  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :new, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
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
        flash[:success] = "De 0 a 3"
        redirect_to users_path
      end
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update_attributes(user_params)
      if params[:user][:photo].present?
        render :crop
      else
        flash[:success] = "Actualización exitosa"
        redirect_to users_path
      end
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario eliminado"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :coordinator, :instructor, :photo, :crop_x, :crop_y, :crop_w, :crop_h )
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end