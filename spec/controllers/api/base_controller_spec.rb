RSpec.describe Api::BaseController, type: :controller do
  controller do
    def index
      raise ApiExceptions::AuthenticationRequired
    end
  end

  describe 'handling authentication' do
    it 'returns a readable response when authentication is required' do
      get :index
      expect(response).to be_unauthorized
      expect(JSON.parse(response.body)).to eq(
        'message' => 'Authentication required',
        'code' => 1000
      )
    end
  end
end
