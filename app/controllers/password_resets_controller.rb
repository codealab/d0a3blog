# encoding: UTF-8
class PasswordResetsController < ApplicationController

  def create
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.authenticate(params[:user][:old_password]) || current_user.administrator?
      if !params[:user][:password].blank?
        if @user.update_attributes(password_params)
          flash[:success] = "Password actualizado correctamente"
          redirect_to root_url
        else
          render 'edit'
        end
      else
        @user.errors.add(:password, "El campo contraseña no puede estar vacío") 
        render 'edit'
      end
    else
      @user.errors.add(:password, "La contraseña actual no coincide con la que has escrito.") 
      render 'edit'
    end
  end

  private
    
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

end