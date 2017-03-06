class Graph::Queries::Users::All < Graph::Queries::Base
  def call
    [
      User.all,
      paginated,
      filtered_by_name
    ].inject(&:merge)
  end

  MAX_LIMIT = 20

  def paginated
    limit = [ args[:first], MAX_LIMIT ].min
    offset = args[:after]
    User.limit(limit).offset(offset)
  end

  def filtered_by_name
    if args[:name]
      User.where(name: args[:name])
    else
      User.all
    end
  end
end
