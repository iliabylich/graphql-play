module ApiExceptions
  module_function

  class Base < StandardError
    attr_reader :code, :message
  end

  def define(exception_name, code:, message:, status:)
    klass = Class.new(Base) do
      define_method(:code)    { code }
      define_method(:message) { message }
      define_method(:status) { status }
    end
    const_set(exception_name, klass)
  end

  define :AuthenticationRequired, code: 1000, message: 'Authentication required', status: :unauthorized
end
