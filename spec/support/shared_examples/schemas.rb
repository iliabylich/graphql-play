RSpec.shared_examples 'schema allows' do |attribute_name, value|
  it "allows value #{value.inspect} for :#{attribute_name}" do
    attributes = minimal_valid_attributes.merge(attribute_name.to_sym => value)
    result = schema.call(attributes)
    expect(result).to be_success
  end
end

RSpec.shared_examples 'schema does not allow' do |attribute_name, value|
  it "does not allow value #{value.inspect} for :#{attribute_name}" do
    attributes = minimal_valid_attributes.merge(attribute_name.to_sym => value)
    result = schema.call(attributes)
    expect(result).to be_failure
  end
end
