class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :setup_devise_params, if: :devise_controller?

  protected

  def setup_devise_params
    devise_parameter_sanitizer.for(:sign_up) << [:username, :avatar]
    devise_parameter_sanitizer.for(:account_update) << [:username, :bio, :avatar]
  end

end
