Graph::QueriesRegistry = GraphQL::ObjectType.define do
  name "QueriesRegistry"
  description "The query root of this schema"

  field :user do
    type Graph::Types::User
    argument :id, !types.Int
    description "Find a User by ID"
    resolve Graph::Queries::Users::Find
  end

  field :users do
    type Graph::Types::User.to_list_type
    argument :first, types.Int, default_value: 20
    argument :after, types.Int, default_value: 0
    argument :name, types.String
    description "List users"
    resolve Graph::Queries::Users::All
  end

  field :post do
    type Graph::Types::Post
    argument :id, !types.Int
    description 'Find a Post by ID'
    resolve Graph::Queries::Posts::Find
  end

  field :posts do
    type Graph::Types::Post.to_list_type
    argument :first, types.Int, default_value: 20
    argument :after, types.Int, default_value: 0
    description 'List posts'
    resolve Graph::Queries::Posts::All
  end
end
