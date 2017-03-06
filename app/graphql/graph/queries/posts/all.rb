class Graph::Queries::Posts::All < Graph::Queries::Base
  def call
    [
      Post.all,
      paginated
    ].inject(&:merge)
  end

  MAX_LIMIT = 20

  def paginated
    limit = [ args[:first], MAX_LIMIT ].min
    offset = args[:after]
    Post.limit(limit).offset(offset)
  end
end
