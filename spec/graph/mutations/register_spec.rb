RSpec.describe 'Graph::Mutations::Register', name: 'register' do
  query_string = <<-QUERY
    mutation RegisterUser($email: String!, $password: String!, $name: String!) {
      register(input: { email: $email, password: $password, name: $name }) {
        success
        user {
          id
          name
          email
        }
        errors {
          field
          messages
        }
      }
    }
  QUERY

  context 'when params are valid' do
    let(:variables) { { 'email' => 'email@email.com', 'password' => 'password', 'name' => 'name' } }

    it 'creates a user' do
      expect {
        Graph::Schema.execute(query_string, variables: variables)
      }.to change { User.count }.by(1)
    end

    it 'returns created user and token' do
      result = Graph::Schema.execute(query_string, variables: variables)
      data = result['data']['register']
      user = User.last

      expect(data).to include(
        'success' => true,
        'user' => {
          'id' => user.id,
          'name' => user.name,
          'email' => user.email
        },
        'errors' => []
      )
    end
  end

  context 'when invalid credentials specified' do
    let(:variables) { { 'email' => 'not-an-email', 'password' => '123', 'name' => 'name' } }

    it 'does not create a user' do
      expect {
        Graph::Schema.execute(query_string, variables: variables)
      }.to_not change {
        User.count
      }
    end

    it 'returns back only errors' do
      result = Graph::Schema.execute(query_string, variables: variables)
      data = result['data']['register']

      expect(data).to eq(
        'success' => false,
        'user' => nil,
        'errors' => [
          { 'field' => 'email', 'messages' => ['is in invalid format'] },
          { 'field' => 'password', 'messages' => ['size cannot be less than 5'] }
        ]
      )
    end
  end
end
