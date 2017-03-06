RSpec.describe Post, type: :model do
  it 'can be created using fabrication' do
    Fabricate(:post)
    expect(Post.count).to eq(1)
  end
end
