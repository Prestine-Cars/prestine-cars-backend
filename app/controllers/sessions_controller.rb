class SessionsController < Devise::SessionsController
  def create
    user = User.find_by(email: sign_in_params[:email])

    if user&.valid_password?(sign_in_params[:password])
      render json: { data: { name: user.name, role: user.role } }
    else
      render json: {
      message: 'user not found'
    }, status: :unprocessable_entity
    end
  end

  def sign_in_params
    params.require(:session).permit(:email, :password)
  end
end