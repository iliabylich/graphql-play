RSpec.describe 'Graph::Mutations::Posts::Create' do

  query_string = <<-QUERY
    mutation CreatePots($title: String!, $body: String!) {
      create_post(input: { title: $title, body: $body }) {
        success
        post {
          id
        }
        errors {
          field
          messages
        }
      }
    }
  QUERY

  let(:variables) { { 'title' => 'title1', 'body' => 'body1' } }

  context 'when user is not signed in' do
    it 'raises auth error' do
      expect {
        Graph::Schema.execute(query_string, variables: variables)
      }.to raise_error(ApiExceptions::AuthenticationRequired)
    end
  end

  context 'when use is signed in' do
    let!(:user) { Fabricate(:user) }
    before { sign_in(user) }

    context 'when params are valid' do
      it 'creates a post' do
        expect {
          Graph::Schema.execute(query_string, variables: variables)
        }.to change {
          Post.count
        }.by(1)
      end

      it 'saves all attributes and assigns a user reference to a current user' do
        Graph::Schema.execute(query_string, variables: variables)
        created_post = Post.last
        expect(created_post).to have_attributes(
          title: 'title1',
          body: 'body1',
          user_id: user.id,
        )
      end

      it 'returns back created post' do
        result = Graph::Schema.execute(query_string, variables: variables)

        created_post = Post.last
        expect(result['data']['create_post']).to eq(
          'success' => true,
          'post' => { 'id' => created_post.id },
          'errors' => []
        )
      end
    end

    context 'when params are invalid' do
      let(:variables) { { 'title' => 'too long' * 100, 'body' => '' } }

      it 'does not create a post' do
        expect {
          Graph::Schema.execute(query_string, variables: variables)
        }.to_not change {
          Post.count
        }
      end

      it 'returns back validation errors' do
        result = Graph::Schema.execute(query_string, variables: variables)
        expect(result['data']['create_post']['errors']).to eq([
          { 'field' => 'title', 'messages' => ['size cannot be greater than 40'] },
          { 'field' => 'body', 'messages' => ['must be filled'] }
        ])
      end
    end
  end
end
