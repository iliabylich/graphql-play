RSpec.describe Graph::Queries::Users::Find, type: :graphql do
  let!(:user) { Fabricate(:user) }

  def query_template(user_id:)
    <<-QUERY
      {
        user(id: #{user_id}) {
          id
          email
          name
        }
      }
    QUERY
  end

  let(:query) { query_template(user_id: user.id) }

  context 'when existing user ID specified' do
    it 'returns it' do
      result = Graph::Schema.execute(query)
      expect(result['data']['user']).to eq(
        'id' => user.id,
        'email' => user.email,
        'name' => user.name
      )
    end
  end

  context 'when unknown user ID specified' do
    let(:invalid_query)  { query_template(user_id: 0) }

    it 'returns blank data' do
      result = Graph::Schema.execute(invalid_query)
      expect(result['data']['user']).to eq(nil)
    end
  end
end
