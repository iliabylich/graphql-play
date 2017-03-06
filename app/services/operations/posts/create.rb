class Operations::Posts::Create < Operations::Base
  class Container < ApplicationContainer
    register :persist, ->(params) {
      post = RequestStore[:current_user].posts.create(params)
      Dry::Monads.Right(post: post, success: true, errors: [])
    }
  end

  TRANSACTION = Dry::Transaction(container: Container) do
    step :authenticate
    step :validate
    step :persist
  end.freeze

  attr_reader :post

  def call
    ActiveRecord::Base.transaction do
      TRANSACTION.call(params, validate: [PostSchema])
    end.value
  end
end
