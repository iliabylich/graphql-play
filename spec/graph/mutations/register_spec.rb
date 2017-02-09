RSpec.describe Graph::Mutations::Register, name: 'register' do
  def query(email:, password:, name:)
    <<-QUERY
      mutation {
        register(input: { email: "#{email}", password: "#{password}", name: "#{name}"}) {
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
  end

  context 'when params are valid' do
    let(:valid_query) { query(email: 'email@email.com', password: 'password', name: 'name') }

    it 'creates a user' do
      expect {
        Graph::Schema.execute(valid_query)
      }.to change { User.count }.by(1)
    end

    it 'returns created user and token' do
      result = Graph::Schema.execute(valid_query)['data']['register']
      user = User.last

      expect(result).to include(
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
    let(:invalid_query) { query(email: 'not-an-email', password: '123', name: 'name') }

    it 'does not create a user' do
      expect {
        Graph::Schema.execute(invalid_query)
      }.to_not change {
        User.count
      }
    end

    it 'returns back only errors' do
      result = Graph::Schema.execute(invalid_query)['data']['register']

      expect(result).to eq(
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
