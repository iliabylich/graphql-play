Graph::Mutations::Register = GraphQL::Relay::Mutation.define do
  name 'Register'
  description 'Registers a user using provided credentials'

  input_field :email, !types.String, 'Your email'
  input_field :password, !types.String, 'Your password'
  input_field :name, !types.String, 'Your name'

  return_field :user, Graph::Types::User, 'Created user record'
  return_field :errors, Graph::Types::Error.to_list_type, 'Validation errors'
  return_field :success, types.Boolean

  resolve Operations::Register
end
