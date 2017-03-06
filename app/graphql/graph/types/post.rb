Graph::Types::Post = GraphQL::ObjectType.define do
  name 'Post'
  description 'Post Record Representation'

  field :id, !types.Int, "Post ID"
  field :title, !types.String, "Post title"
  field :body, !types.String, "Post body"
end
