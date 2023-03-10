class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  # To handle the POST request from the command line to the /api/v1/users/:id/posts/:post_id/comments.json
  def verified_request?
    super || request_from_localhost?
  end

  def request_from_localhost?
    request.remote_ip == '127.0.0.1' || request.remote_ip == '::1'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :photo, :bio) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password, :photo, :bio)
    end
  end
end
