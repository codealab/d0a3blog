# encoding: UTF-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  helper_method :manager

  before_action :require_login
  before_action :user_visor, only: [:update, :create, :destroy]
  before_action :set_locale

  def set_locale
    I18n.locale = :es
  end
  
  private

  def require_login
    cookies.permanent[:previous] = request.url
    unless signed_in?
      flash[:danger] = "Inicia sesión"
      redirect_to signin_url # halts request cycle
    end
  end

  def user_visor
    redirect_to(:back, notice:"No tienes los permisos suficientes para llevar a cabo esta tarea.") unless manager
  end

  def manager
    current_user.admin? || current_user.facilitator? || current_user.coordinator?
  end

end