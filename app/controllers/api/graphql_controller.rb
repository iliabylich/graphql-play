class Api::GraphqlController < Api::BaseController
  def run
    query = params[:query]
    result = Graph::Schema.execute(query)
    render json: result
  end

  def docs
  end
end
