Graph::QueriesRegistry = GraphQL::ObjectType.define do
  name "QueriesRegistry"
  description "The query root of this schema"

  field :user do
    type Graph::Types::User
    argument :id, !types.Int
    description "Find a User by ID"
    resolve Graph::Queries::Users::Find
  end
end
