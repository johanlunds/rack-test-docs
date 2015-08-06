require "rspec"

require "rack_test_docs/version"
require "rack_test_docs/rspec_formatter"

module RackTestDocs
  # Your code goes here...
end

RSpec.configure do |config|
  config.add_formatter RackTestDocs::RSpecFormatter
end