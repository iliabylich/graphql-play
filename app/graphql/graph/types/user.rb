Graph::Types::User = GraphQL::ObjectType.define do
  name 'User'
  description 'User Record Representation'

  field :id, !types.Int, "User's ID"
  field :email, !types.String, "User's email"
  field :name, !types.String, "User's name"

  field :posts, Graph::Types::Post.to_list_type
end
