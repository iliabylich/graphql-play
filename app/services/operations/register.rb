class Operations::Register < Operations::Base
  class Container < ApplicationContainer
    register :persist, ->(params) {
      user = User.create(params)
      Dry::Monads.Right(user: user, success: true, errors: [])
    }
  end

  TRANSACTION = Dry.Transaction(container: Container) do
    step :validate
    step :persist
  end.freeze

  def call
    ActiveRecord::Base.transaction do
      TRANSACTION.call(params, validate: [RegistrationSchema])
    end.value
  end
end
