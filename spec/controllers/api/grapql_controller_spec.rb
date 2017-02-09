RSpec.describe Api::GraphqlController, type: :controller do
  describe '#run' do
    let!(:user) { Fabricate(:user, email: 'email@email.com', password: 'secret') }
    let(:find_user_query) do
      <<-QUERY
        {
          user(id: #{user.id}) {
            id
            email
            name
          }
        }
      QUERY
    end

    context 'when not authenticated' do
      it 'requires authentication' do
        post :run, params: { query: find_user_query }
        expect(response).to be_unauthorized
        expect(JSON.parse(response.body)).to eq(
          'message' => 'Authentication required',
          'code' => 1000
        )
      end
    end

    context 'when authenticated' do

      let(:auth_query) do
        <<-QUERY
          mutation {
            sign_in(input: { email: "email@email.com", password: "secret" }) {
              success
              access_token
              user {
                id
              }
            }
          }
        QUERY
      end

      it 'runs the query and returns its result' do
        post :run, params: { query: auth_query }
        access_token = JSON.parse(response.body)['data']['sign_in']['access_token']

        @request.headers['Authorization'] = "Bearer #{access_token}"
        post :run, params: { query: find_user_query }
        expect(JSON.parse(response.body)['data']['user']['name']).to eq(user.name)
      end
    end
  end
end
