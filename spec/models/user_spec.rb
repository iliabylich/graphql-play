RSpec.describe User, type: :model do
  it 'can be created using fabrication' do
    Fabricate(:user)
    expect(User.count).to eq(1)
  end

  it 'supports passing followers as options' do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user, followers: [user1])

    expect(user2.followers).to eq([user1])
    expect(user2.followings).to eq([])

    expect(user1.followers).to eq([])
    expect(user1.followings).to eq([user2])
  end
end
