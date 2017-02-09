Graph::Types::User = GraphQL::ObjectType.define do
  name 'UserRecord'

  field :id, !types.Int
  field :email, !types.String
  field :name, !types.String
end
