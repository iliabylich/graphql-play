class Operations::Users::Follow < Operations::Base
  class Validator
    ERROR = ApiError::I18n.to_monad('errors.follow.duplicate').freeze

    def self.call(target_user, current_user = Auth.current_user)
      if Auth.current_user.follows?(target_user)
        ERROR
      else
        Dry::Monads.Right(target_user)
      end
    end
  end

  class Container < Containers::UsersContainer
    register :validate_no_duplicates, ->(user) {
      Validator.call(user)
    }

    register :follow, ->(user) {
      Auth.current_user.followings << user
      Dry::Monads.Right(success: true, errors: [])
    }
  end

  TRANSACTION = Dry.Transaction(container: Container) do
    step :authenticate
    step :fetch_user
    step :ensure_user_exists
    step :validate_no_duplicates
    step :follow
  end.freeze

  def call
    ActiveRecord::Base.transaction { TRANSACTION.call(params) }.value
  end
end
