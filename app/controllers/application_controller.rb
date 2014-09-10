# encoding: UTF-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :json_request?
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  include SessionsHelper

  before_action :require_login

  rescue_from CanCan::AccessDenied do |exception|
    if !request.env["HTTP_REFERER"].blank? # and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
    	redirect_to(:back, notice:"No tienes permiso para llevar a cabo esta acción.")
    else
    	redirect_to(root_path, notice:"No tienes permiso para llevar a cabo esta acción.")
    end
  end

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

  def json_request?
    request.format.json?
  end

end