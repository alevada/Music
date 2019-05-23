
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

=begin
  def current_user
    @current_user ||= session[:user_id] && User.find_by_id(session[:user_id])
    #                             ^ la fel ca User.find (1)
  end
=end

  def after_sign_in_path_for(current_user)
    user_path(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

end
