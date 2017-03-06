Graph::Mutations::Posts::Create = GraphQL::Relay::Mutation.define do
  name 'CreatePost'
  description 'Creates a post for current user using provided title and body'

  input_field :title, !types.String, 'Post title, < 40 chars'
  input_field :body, !types.String, 'Post body, < 200 chars'

  return_field :post, Graph::Types::Post, 'Created user record'
  return_field :errors, Graph::Types::Error.to_list_type, 'Validation errors'
  return_field :success, types.Boolean

  resolve Operations::Posts::Create
end
