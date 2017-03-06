class Operations::Base
  class << self
    def call(obj, args, context)
      new(args.to_h.with_indifferent_access).call
    end
  end

  attr_reader :params

  def initialize(params)
    @params = params
    freeze
  end

  def call
    raise NotImplementedError
  end
end
