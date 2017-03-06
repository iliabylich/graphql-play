RSpec.describe Graph::Queries::Posts::Find, type: :graphql do
  let!(:post) { Fabricate(:post) }

  query_string = <<-QUERY
    query findPost($post_id: Int!) {
      post(id: $post_id) {
        id
        title
        body
        user {
          id
        }
      }
    }
  QUERY

  context 'when existing post ID specified' do
    it 'returns it' do
      result = Graph::Schema.execute(query_string, variables: { 'post_id' => post.id })

      expect(result['data']['post']).to eq(
        'id' => post.id,
        'title' => post.title,
        'body' => post.body,
        'user' => { 'id' => post.user.id }
      )
    end
  end

  context 'when unknown post ID specified' do
    it 'returns blank data' do
      result = Graph::Schema.execute(query_string, variables: { 'post_id' => 0 })
      expect(result['data']['post']).to eq(nil)
    end
  end
end
