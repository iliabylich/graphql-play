class Api::BaseController < ApplicationController
  before_action :try_to_authenticate_user

  rescue_from ApiExceptions::Base, with: :respond_with_api_exception

  private

  def try_to_authenticate_user
    if request.headers['Authorization']
      token = request.headers['Authorization'].split.last
      RequestStore[:current_user] = Auth::TokenVerifier.new(token).user
    end
  end

  def respond_with_api_exception(e)
    render json: { message: e.message, code: e.code }, status: e.status
  end
end
