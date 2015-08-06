# TODOs

Add Rubocop to .travis.yml

# Implementation notes

custom formatter
- add subclass
  class RackTestDocFormatter
    RSpec::Core::Formatters.register self, :start, :example_group_started, :close

    def initialize(output)
    end
  end
- to use this formatter one should add to `.rspec`: `-f RackTestDocFormatter` (maybee need to make sure to specify at least 2 formatters then)

hook into :type => :request
- include Module
  Rspec.configure do |c|
    c.include MyModule, type: :request
  end

- it should override #process
  - it should access request + response
  - it should emit `current_example.reporter.publish :my_custom_event, { my_options: ...}` ie. `.publish :rack_request_performed, { request: request, response: response }`