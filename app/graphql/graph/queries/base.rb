class Graph::Queries::Base
  def self.call(object, args, context)
    new(object, args, context).call
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