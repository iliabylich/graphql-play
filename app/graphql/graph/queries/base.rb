class Graph::Queries::Base
  class << self
    def call(object, args, context)
      if requires_authentication?
        Auth.require_authentication!
      end

      new(object, args, context).call
    end

    def requires_authentication!
      @requires_authentication = true
    end

    def requires_authentication?
      !!@requires_authentication
    end
  end

  attr_reader :object, :args, :context

  def initialize(object, args, context)
    @object = object
    @args = args
    @context = context
  end

  def call
    raise NotImplementedError
  end
end