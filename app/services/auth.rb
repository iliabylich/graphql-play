module Auth
  extend self

  attr_accessor :token_lifespan
  self.token_lifespan = 1.day

  def secret
    Rails.application.secrets.secret_key_base
  end

  def require!
    raise ApiExceptions::AuthenticationRequired unless current_user
  end

  def current_user
    RequestStore[:current_user]
  end

  attr_accessor :enabled
  self.enabled = true

  def disable
    self.enabled = false
    yield
  ensure
    self.enabled = true
  end

  class TokenGenerator
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def token
      payload = { user_id: user.id, exp: Auth.token_lifespan.from_now.to_i }
      JWT.encode(payload, Auth.secret, 'HS256')
    end
  end

  class TokenVerifier
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def user
      payload, header = JWT.decode(token, Auth.secret, true, algorithm: 'HS256')
      User.find(payload['user_id'])
    rescue => e
      nil
    end
  end
end
