# encoding: UTF-8
class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :user_visor, only: [:create, :destroy]
  
	def new
	end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash.now[:success] = 'Bienvenido a "De Cero a Tres"'
      sign_in user
    else
      flash.now[:error] = 'Combinación de email/password errónea.'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if verify_old_password
      if @user.update_attributes(password_params)
        flash[:success] = "Actualización exitosa"
        redirect_to @user
      end
    else
      flash[:error] = "La contraseña actual"
    end
  end 


  def destroy
    sign_out
    redirect_to root_url  
  end

  private

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

end