# encoding: UTF-8
class PasswordResetsController < ApplicationController

  skip_before_action :user_visor, only: [:create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def create
    # user = User.find(params[:id])
    # user.send_password_reset if user
    # redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    #@user = User.find_by_password_reset_token!(params[:id])
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.authenticate(params[:user][:old_password]) || @user.admin?
      if @user.update_attributes(password_params)
        flash[:success] = "Password cambiado"
        redirect_to root_url
      else
        render 'edit'
      end
    else
      flash[:error] = "Mala verificacion"
      render 'edit'
    end
  end

  private
    
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def verify_old_password
      @user.password == params[:old_pasword]
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

end