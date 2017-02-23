RSpec.describe 'Graph::Mutations::SignIn' do
  let!(:user) { Fabricate(:user) }

  query_string = <<-QUERY
    mutation SignIn($email: String!, $password: String!) {
      sign_in(input: { email: $email, password: $password }) {
        success
        user {
          id
        }
      }
    }
  QUERY

  context 'when valid credentials specified' do
    let(:variables) { { 'email' => user.email, 'password' => 'password' } }

    it 'returns back the user' do
      result = Graph::Schema.execute(query_string, variables: variables)

      expect(result['data']['sign_in']).to eq('success' => true, 'user' => { 'id' => user.id })
    end
  end

  context 'when invalid credentials specified' do
    let(:variables) { { 'email' => user.email, 'password' => 'wrong' } }

    it 'returns back nil' do
      result = Graph::Schema.execute(query_string, variables: variables)

      expect(result['data']['sign_in']).to eq('success' => false, 'user' => nil)
    end
  end
end
