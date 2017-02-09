Graph::Mutations::SignIn = GraphQL::Relay::Mutation.define do
  name 'SignIn'

  input_field :email, !types.String
  input_field :password, !types.String

  return_field :user, Graph::Types::User
  return_field :success, types.Boolean
  return_field :access_token, types.String

  resolve Operations::SignIn
end
