Graph::Schema = GraphQL::Schema.define do
  mutation Graph::MutationsRegistry
  query Graph::QueriesRegistry
end
