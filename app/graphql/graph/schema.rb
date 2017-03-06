Graph::Schema = GraphQL::Schema.define do
  mutation Graph::MutationsRegistry
  query Graph::QueriesRegistry

  lazy_resolve(Promise, :sync)
  instrument(:query, GraphQL::Batch::Setup)
end
