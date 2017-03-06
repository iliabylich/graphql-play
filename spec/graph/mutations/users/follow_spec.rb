RSpec.describe 'Graph::Mutations::Users::Follow' do
  query_string = <<-QUERY
    mutation FollowUser($user_id: Int!) {
      follow(input: { user_id: $user_id }) {
        success
        errors {
          field
          messages
        }
      }
    }
  QUERY

  context 'when user is not signed in' do
    it 'raises auth error' do
      expect {
        Graph::Schema.execute(query_string, variables: { 'user_id' => 1 })
      }.to raise_error(ApiExceptions::AuthenticationRequired)
    end
  end

  context 'when user is signed in' do
    let!(:user1) { Fabricate(:user) }
    let!(:user2) { Fabricate(:user) }

    before { sign_in(user1) }

    context 'when params are valid' do
      it 'follows specified user' do
        expect {
          Graph::Schema.execute(query_string, variables: { 'user_id' => user2.id })
        }.to change {
          user1.reload.followings.to_a
        }.from([]).to([user2])
      end

      it 'returns back success=true and errors=[]' do
        result = Graph::Schema.execute(query_string, variables: { 'user_id' => user2.id })
        expect(result['data']['follow']).to eq(
          'success' => true,
          'errors' => []
        )
      end
    end

    context 'when unknown user_id specified' do
      it 'returns back success=false and error message' do
        result = Graph::Schema.execute(query_string, variables: { 'user_id' => -1 })
        expect(result['data']['follow']).to eq(
          'success' => false,
          'errors' => [
            { 'field' => 'base', 'messages' => [I18n.t('errors.users.doesnt_exist')] }
          ]
        )
      end
    end

    context 'when current user already follows specified user' do
      before { user1.followings << user2 }

      it 'returns success=false and error message' do
        result = Graph::Schema.execute(query_string, variables: { 'user_id' => user2.id })
        expect(result['data']['follow']).to eq(
          'success' => false,
          'errors' => [
            { 'field' => 'base', 'messages' => [I18n.t('errors.follow.duplicate')] }
          ]
        )
      end
    end
  end
end
