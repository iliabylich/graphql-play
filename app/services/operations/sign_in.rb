class Operations::SignIn < Operations::Base
  attr_reader :user, :access_token

  def call
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      RequestStore[:current_user] = @user = user,
      @access_token = Auth::TokenGenerator.new(user).token
    end
  end

  def payload
    {
      user: user,
      success: !!user,
      access_token: access_token
    }
  end
end
