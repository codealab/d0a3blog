# encoding: UTF-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  include SessionsHelper
  include PersonsHelper
  include PaymentsHelper

  before_action :require_login
  before_action :user_visor, only: [:update, :create, :destroy]
  before_action :set_locale

  def set_locale
    I18n.locale = :es
  end
  
  private

  def record_not_found
    render :file => 'public/404.html', :status => :not_found, :layout => true
  end

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

end