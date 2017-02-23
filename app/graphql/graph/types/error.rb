Graph::Types::Error = GraphQL::ObjectType.define do
  name 'RecordError'
  description 'Error caused by mutation'

  field :field, !types.String, 'Field that has an error'
  field :messages, !types.String.to_list_type, 'Error messages'
end
