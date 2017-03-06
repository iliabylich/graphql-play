RSpec.describe 'PostSchema' do
  subject(:schema) { PostSchema }

  let(:minimal_valid_attributes) do
    {
      title: 'title',
      body: 'body'
    }
  end

  context '#/title' do
    include_examples 'schema allows', :title, 'title'
    include_examples 'schema allows', :title, 'multiple worlds'
    include_examples 'schema allows', :title, 'a' * 40
    include_examples 'schema does not allow', :title, nil
    include_examples 'schema does not allow', :title, ''
    include_examples 'schema does not allow', :title, 'a' * 41
  end

  context '#/body' do
    include_examples 'schema allows', :body, 'body'
    include_examples 'schema allows', :body, 'multiple words'
    include_examples 'schema allows', :body, 'a' * 200
    include_examples 'schema does not allow', :body, nil
    include_examples 'schema does not allow', :body, ''
    include_examples 'schema does not allow', :body, 'a' * 201
  end
end
