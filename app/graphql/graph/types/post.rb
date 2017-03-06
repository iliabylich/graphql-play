Graph::Types::Post = GraphQL::ObjectType.define do
  name 'Post'
  description 'Post Record Representation'

  field :id, !types.Int, "Post ID"
  field :title, !types.String, "Post title"
  field :body, !types.String, "Post body"

  field :user, Graph::Types::User do
    resolve ->(post, *) {
      Graph::Loaders::RecordLoader.for(User).load(post.user_id)
    }
  end
end
