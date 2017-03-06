class Graph::Queries::Posts::Find < Graph::Queries::Base
  def call
    Post.find_by(id: args[:id])
  end
end
