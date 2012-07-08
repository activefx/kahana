# Uncomment to
# require 'simplecov'
# SimpleCov.start

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'pry'
require 'faraday'
require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'kahana'

# Place sensitive gem configuration files in spec/configuration.yml and
# ensure that file is included in .gitignore to keep constants such as passwords
# and API keys private in publically released gems
CONFIGURATION_DEFAULTS = begin
  YAML::load_file("#{File.dirname(__FILE__)}/configuration.yml").inject({}) do |options, (key, value)|
    options[(key.to_sym rescue key) || key] = value
    options
  end
rescue
  # Create a hash of default configuration options
  { :api_key => 'ValidApiKey' }
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include WebMock::API
  config.extend VCR::RSpec::Macros
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.before(:each) do
    # Logic to run before all examples
  end
end

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock #:typhoeus, :faraday, :fakeweb, or :webmock
  config.default_cassette_options = { :record => :new_episodes }
  config.filter_sensitive_data('ValidApiKey') { CONFIGURATION_DEFAULTS[:api_key] }
end

def configuration_defaults
  CONFIGURATION_DEFAULTS
end

