class ApiError < Struct.new(:field, :messages)
  def initialize(*)
    super
    freeze
  end

  def self.of(hash)
    if hash.is_a?(Hash)
      hash.map do |field, messages|
        new(field, messages)
      end
    else
      []
    end
  end

  module I18n
    def self.to_monad(locale_key)
      message = ::I18n.t(locale_key)
      error = ::ApiError.new(:base, [message])

      Dry::Monads.Left(success: false, errors: [error])
    end
  end
end
