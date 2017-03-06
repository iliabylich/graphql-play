RSpec.describe Graph::Queries::Posts::All, type: :graphql do
  let!(:posts) { Fabricate.times(30, :post) }

  query_string = <<-QUERY
    query findPosts($first: Int, $after: Int) {
      posts(first: $first, after: $after) {
        id
        title
        user {
          id
        }
      }
    }
  QUERY

  context 'defaults' do
    it 'returns 20 first posts' do
      result = Graph::Schema.execute(query_string)
      posts = result['data']['posts']

      expect(posts).to be_an(Array)
      expect(posts.length).to eq(20)

      ids = posts.map { |u| u['id'] }
      expect(ids).to eq(Post.limit(20).ids)
    end
  end

  context 'when after specified' do
    it 'skips N posts' do
      result = Graph::Schema.execute(query_string, variables: { 'after' => 2 })
      posts = result['data']['posts']

      expect(posts).to be_an(Array)
      expect(posts.length).to eq(20)

      ids = posts.map { |u| u['id'] }
      expect(ids).to eq(Post.limit(20).offset(2).ids)
    end
  end

  context 'when first specified' do
    it 'return N first posts' do
      result = Graph::Schema.execute(query_string, variables: { 'first' => 5 })
      posts = result['data']['posts']

      expect(posts).to be_an(Array)
      expect(posts.length).to eq(5)

      ids = posts.map { |u| u['id'] }
      expect(ids).to eq(Post.limit(5).ids)
    end
  end
end
