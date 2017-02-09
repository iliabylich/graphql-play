class Graph::Queries::Users::Find < Graph::Queries::Base
  def call
    User.find_by(id: args[:id])
  end
end
