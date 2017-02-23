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
    argument :skip, types.Int, default_value: 0
    argument :limit, types.Int, default_value: 20
    argument :name, types.String
    resolve Graph::Queries::Users::All
  end
end
