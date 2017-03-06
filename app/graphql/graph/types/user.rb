Graph::Types::User = GraphQL::ObjectType.define do
  name 'User'
  description 'User Record Representation'

  field :id, !types.Int, "User's ID"
  field :email, !types.String, "User's email"
  field :name, !types.String, "User's name"

  connection :posts, Graph::Types::Post.connection_type do
    resolve ->(user, *) {
      Graph::Loaders::AssociationLoader.for(User, :posts).load(user)
    }
  end
end
