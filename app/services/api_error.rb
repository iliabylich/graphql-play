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
end
