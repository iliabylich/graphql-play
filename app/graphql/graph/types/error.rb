Graph::Types::Error = GraphQL::ObjectType.define do
  name 'RecordError'

  field :field, !types.String
  field :messages, !types.String.to_list_type
end
