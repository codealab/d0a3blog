# encoding: UTF-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  helper_method :manager

  before_action :require_login, only: :index
  before_action :user_visor, only: [:update, :create, :destroy]

  private
 
  def require_login
    unless signed_in?
      flash[:error] = "Inicia sesión"
      redirect_to signin_url # halts request cycle
    end
  end

  protected

  def user_visor
    redirect_to(:back, notice:"No tienes los permisos suficientes para llevar a cabo esta tarea.") unless manager
  end

  def manager
    current_user.admin? || current_user.facilitator? || current_user.coordinator?
  end

end