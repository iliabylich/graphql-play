module AuthHelper
  def mock_authentication
    before(:each) do
      allow(Auth).to receive(:require_authentication!).and_return(true)
    end
  end
end

RSpec.configure do |c|
  c.extend AuthHelper, type: :graphql
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
