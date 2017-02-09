class Operations::Register < Operations::Base
  attr_reader :user

  def call
    schema = RegistrationSchema.call(params)

    if schema.success?
      @user = User.create(schema.output)
      # TODO: Send an email
    else
      @errors = schema.errors
    end
  end

  def payload
    super.merge(user: user)
  end
end
