RSpec.describe User, type: :model do
  it 'can be created using fabrication' do
    Fabricate(:user)
    expect(User.count).to eq(1)
  end
end
