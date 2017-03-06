class Operations::SignIn < Operations::Base
  class Container
    extend Dry::Container::Mixin

    register :authenticate, ->(params) {
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        Dry::Monads.Right(user)
      else
        Dry::Monads.Left(user: nil, success: false, access_token: nil)
      end
    }

    register :generate_access_token, ->(user) {
      access_token = Auth::TokenGenerator.new(user).token
      Dry::Monads.Right(user: user, success: true, access_token: access_token)
    }
  end

  TRANSACTION = Dry.Transaction(container: Container) do
    step :authenticate
    step :generate_access_token
  end.freeze

  def call
    ActiveRecord::Base.transaction { TRANSACTION.call(params) }.value
  end
end
