class ApplicationController < ActionController::API
  before_action :update_allowed_parameters, if: :devise_controller?

  include Response
  include ExceptionHandler
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  def authenticate_request!
    return invalid_authentication if !payload || !AuthenticationTokenService.valid_payload(payload.first)

    current_user!
    invalid_authentication unless @current_user
  end

  def current_user!
    @current_user = User.find_by(id: payload[0]['user_id'])
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
  end

  private

  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split.last
    AuthenticationTokenService.decode(token)
  rescue StandardError
    nil
  end

  def invalid_authentication
    render json: { error: 'You will need to login first' }, status: :unauthorized
  end

  # def authenticate_user!(_ = {})
  #   render json: { error: 'You must be logged in' }, status: :unauthorized unless signed_in?
  # end

  # def current_user
  #   @current_user ||= super || User.find(@current_user_id)
  # end

  # def signed_in?
  #   @current_user_id.present?
  # end
end
