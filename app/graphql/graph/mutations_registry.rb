Graph::MutationsRegistry = GraphQL::ObjectType.define do
  name 'MutationRegistry'

  field :register, field: Graph::Mutations::Register.field
  field :sign_in,  field: Graph::Mutations::SignIn.field

  field :create_post, field: Graph::Mutations::Posts::Create.field
end
