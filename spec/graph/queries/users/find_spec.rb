RSpec.describe Graph::Queries::Users::Find, type: :graphql do
  let!(:user) { Fabricate(:user) }

  query_string = <<-QUERY
    query findUser($user_id: Int!) {
      user(id: $user_id) {
        id
        email
        name
      }
    }
  QUERY

  context 'when existing user ID specified' do
    it 'returns it' do
      result = Graph::Schema.execute(query_string, variables: { 'user_id' => user.id })
      expect(result['data']['user']).to eq(
        'id' => user.id,
        'email' => user.email,
        'name' => user.name
      )
    end
  end

  context 'when unknown user ID specified' do
    it 'returns blank data' do
      result = Graph::Schema.execute(query_string, variables: { 'user_id' => 0 })
      expect(result['data']['user']).to eq(nil)
    end
  end
end
