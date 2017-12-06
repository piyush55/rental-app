require 'vcr'
require 'fakeweb'
require 'capybara/rspec'

RSpec.configure do |config|
  config.formatter = :documentation
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.around(:each) do |example|
    if example.metadata[:type] == :feature
      Capybara.configure do |conf|
        conf.default_max_wait_time = 10
        conf.run_server = true
        conf.default_driver = :selenium
      end
      VCR.configuration.ignore_request { true }
      VCR.turned_off { example.run }
    else
      example.run
    end
  end
end
require File.expand_path('app/services/location/base')
require File.expand_path('app/services/location/airbnb')

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :fakeweb
  c.configure_rspec_metadata!
end
