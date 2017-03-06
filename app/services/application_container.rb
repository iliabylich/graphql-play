class ApplicationContainer
  extend Dry::Container::Mixin

  register :authenticate, ->(*args) {
    Auth.require!
    Dry::Monads.Right(*args)
  }

  register :validate, ->(params, schema) {
    result = schema.call(params)
    if result.success?
      Dry::Monads.Right(result.output)
    else
      Dry::Monads.Left(errors: ApiError.of(result.errors), success: false)
    end
  }
end
