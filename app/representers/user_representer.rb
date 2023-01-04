class UserRepresenter
  def initialize(user)
    @user = user
  end

  def as_json
    {
      user:,
      token: AuthenticationTokenService.call(user.id)
    }
  end

  private

  attr_reader :user
end
