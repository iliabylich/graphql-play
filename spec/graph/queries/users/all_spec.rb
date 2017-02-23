RSpec.describe Graph::Queries::Users::All, type: :graphql do
  let!(:users) { Fabricate.times(30, :user) }

  query_string = <<-QUERY
    query findUsers($skip: Int, $limit: Int, $name: String) {
      users(skip: $skip, limit: $limit, name: $name) {
        id
        email
        name
      }
    }
  QUERY

  context 'defaults' do
    it 'returns 20 first users' do
      result = Graph::Schema.execute(query_string)
      users = result['data']['users']

      expect(users).to be_an(Array)
      expect(users.length).to eq(20)

      ids = users.map { |u| u['id'] }
      expect(ids).to eq(User.limit(20).ids)
    end
  end

  context 'when skip specified' do
    it 'skips N users' do
      result = Graph::Schema.execute(query_string, variables: { 'skip' => 2 })
      users = result['data']['users']

      expect(users).to be_an(Array)
      expect(users.length).to eq(20)

      ids = users.map { |u| u['id'] }
      expect(ids).to eq(User.limit(20).offset(2).ids)
    end
  end

  context 'when limit specified' do
    it 'return N first users' do
      result = Graph::Schema.execute(query_string, variables: { 'limit' => 5 })
      users = result['data']['users']

      expect(users).to be_an(Array)
      expect(users.length).to eq(5)

      ids = users.map { |u| u['id'] }
      expect(ids).to eq(User.limit(5).ids)
    end
  end

  context 'when name specified' do
    let!(:user) { Fabricate(:user, name: 'specified name') }

    it 'returns only matching users' do
      result = Graph::Schema.execute(query_string, variables: { 'name' => user.name })
      users = result['data']['users']

      expect(users).to be_an(Array)
      expect(users.length).to eq(1)

      user_response = users[0]
      expect(user_response['id']).to eq(user.id)
    end
  end
end
