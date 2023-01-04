class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserRepresenter.new(@user).as_json, status: :created
    else
      render json: { error: @user.errors.full_messages.first }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
