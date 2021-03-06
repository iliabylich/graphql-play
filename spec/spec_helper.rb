ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

$: << Rails.root.to_s

ActiveRecord::Migration.maintain_test_schema!

Dir['spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.disable_monkey_patching!

  config.before(:each) do
    RequestStore.clear!
  end
end
