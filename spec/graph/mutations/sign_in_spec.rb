RSpec.describe Graph::Mutations::SignIn do
  let!(:user) { Fabricate(:user) }

  def query(email:, password:)
    <<-QUERY
      mutation {
        sign_in(input: { email: "#{email}", password: "#{password}" }) {
          success
          user {
            id
          }
        }
      }
    QUERY
  end

  context 'when valid credentials specified' do
    it 'returns back the user' do
      result = Graph::Schema.execute(query(email: user.email, password: 'password'))

      expect(result['data']['sign_in']).to eq('success' => true, 'user' => { 'id' => user.id })
    end
  end

  context 'when invalid credentials specified' do
    it 'returns back nil' do
      result = Graph::Schema.execute(query(email: user.email, password: 'wrong'))

      expect(result['data']['sign_in']).to eq('success' => false, 'user' => nil)
    end
  end
end
