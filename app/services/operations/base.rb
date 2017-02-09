class Operations::Base
  class << self
    def call(obj, args, context)
      op = new(args.to_h.with_indifferent_access)

      if requires_authentication?
        Auth.require_authentication!
      end

      op.call
      op.payload
    end

    def requires_authentication!
      @requires_authentication = true
    end

    def requires_authentication?
      !!@requires_authentication
    end
  end

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    raise NotImplemented
  end

  def payload
    {
      errors: errors,
      success: errors.nil? || errors.empty?
    }
  end

  Error = Struct.new(:field, :messages)

  def errors
    if @errors
      @errors.map do |field, messages|
        Error.new(field, messages)
      end
    else
      []
    end
  end
end
