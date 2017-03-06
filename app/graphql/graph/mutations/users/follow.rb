Graph::Mutations::Users::Follow = GraphQL::Relay::Mutation.define do
  name 'FollowUser'
  description 'Follows specified user by currently logged in user'

  input_field :user_id, !types.Int, 'Target user ID'

  return_field :success, types.Boolean
  return_field :errors, Graph::Types::Error.to_list_type, 'Validation errors'

  resolve Operations::Users::Follow
end
