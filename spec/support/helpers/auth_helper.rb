module AuthHelper
  def sign_in(user = Fabricate(:user))
    RequestStore[:current_user] = user
  end
end

RSpec.configure do |c|
  c.include AuthHelper
end

# @let-dep query [String]
#
RSpec.shared_examples 'query requires authentication' do
  context 'when not authenticated' do
    it 'raises an exception' do
      expect {
        Graph::Schema.execute(query)
      }.to raise_error(ApiExceptions::AuthenticationRequired)
    end
  end
end
