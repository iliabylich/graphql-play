Graph::Mutations::SignIn = GraphQL::Relay::Mutation.define do
  name 'SignIn'
  description 'Performs sign in using provided credentials'

  input_field :email, !types.String, 'Your email'
  input_field :password, !types.String, 'Your password'

  return_field :user, Graph::Types::User, 'Your user record'
  return_field :success, types.Boolean
  return_field :access_token, types.String, 'Token that can be later used to perform actions'

  resolve Operations::SignIn
end
