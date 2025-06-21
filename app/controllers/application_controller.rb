class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_admin
    redirect_to login_path unless @current_user&.admin?
  end

  helper_method :current_user
end
