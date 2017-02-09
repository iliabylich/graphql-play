Graph::Mutations::Register = GraphQL::Relay::Mutation.define do
  name 'Register'

  input_field :email, !types.String
  input_field :password, !types.String
  input_field :name, !types.String

  return_field :user, Graph::Types::User
  return_field :errors, Graph::Types::Error.to_list_type
  return_field :success, types.Boolean

  resolve Operations::Register
end
