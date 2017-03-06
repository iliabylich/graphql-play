class Containers::UsersContainer < ApplicationContainer
  register :fetch_user, ->(user_id:) {
    user = User.find_by(id: user_id)
    Dry::Monads.Right(user)
  }

  register :ensure_user_exists, ->(user) {
    UserExistsValidator.call(user)
  }

  class UserExistsValidator
    ERROR = ApiError::I18n.to_monad('errors.users.doesnt_exist').freeze

    def self.call(user)
      if user
        Dry::Monads.Right(user)
      else
        ERROR
      end
    end
  end
end
