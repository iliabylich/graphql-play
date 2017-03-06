class Operations::Users::Unfollow < Operations::Base
  class Validator
    ERROR = ApiError::I18n.to_monad('errors.unfollow.cant_unfollow').freeze

    def self.call(target_user, current_user = Auth.current_user)
      if current_user.follows?(target_user)
        Dry::Monads.Right(target_user)
      else
        ERROR
      end
    end
  end

  class Container < Containers::UsersContainer
    register :validate_follows, ->(user) {
      Validator.call(user)
    }

    register :unfollow, ->(user) {
      Auth.current_user.followings.delete(user)
      Dry::Monads.Right(success: true, errors: [])
    }
  end

  TRANSACTION = Dry.Transaction(container: Container) do
    step :authenticate
    step :fetch_user
    step :ensure_user_exists
    step :validate_follows
    step :unfollow
  end.freeze

  def call
    ActiveRecord::Base.transaction { TRANSACTION.call(params) }.value
  end
end
