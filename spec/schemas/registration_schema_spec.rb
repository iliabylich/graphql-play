RSpec.describe 'RegistrationSchema' do
  subject(:schema) { RegistrationSchema }

  let(:minimal_valid_attributes) do
    {
      email: 'email@email.com',
      password: 'password1',
      name: 'name'
    }
  end

  context '#/email' do
    include_examples 'schema allows', :email, 'email@email.com'
    include_examples 'schema does not allow', :email, nil
    include_examples 'schema does not allow', :email, ''
    include_examples 'schema does not allow', :email, 'not-an-email'
    include_examples 'schema does not allow', :email, '@email.com'
  end

  context '#/password' do
    include_examples 'schema allows', :password, '>=5chars'
    include_examples 'schema allows', :password, 'spaces inside'
    include_examples 'schema does not allow', :password, nil
    include_examples 'schema does not allow', :password, ''
    include_examples 'schema does not allow', :password, '<5'
  end

  context '#/name' do
    include_examples 'schema allows', :name, 'any name'
    include_examples 'schema does not allow', :name, nil
    include_examples 'schema does not allow', :name, ''
  end
end
