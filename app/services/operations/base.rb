class Operations::Base
  class << self
    def call(obj, args, context)
      new(args.to_h.deep_symbolize_keys).call
    end
  end

  attr_reader :params

  def initialize(params)
    @params = params.freeze
    freeze
  end

  def call
    raise NotImplementedError
  end
end
