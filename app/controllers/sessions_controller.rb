class SessionsController < ApplicationController
  def create
    user = User.find_by(email: sign_in_params[:email])

    if user&.valid_password?(sign_in_params[:password])
      render json: UserRepresenter.new(user).as_json, status: :created
    else
      render json: {
        message: 'User not found'
      }, status: :unprocessable_entity
    end
  end

  protected

  def success_session_destroy
    render status: :no_content, json: {}
  end

  private

  def user
    @user ||= User.find_by(email: sign_in_params[:email])
  end

  def parameter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end

  def handle_unauthenticated
    render json: { error: 'Incorrect password ' }, status: :unauthorized
  end

  def sign_in_params
    params.require(:session).permit(:email, :password)
  end
end
