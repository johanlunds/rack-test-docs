module RackTestDocs
  class RSpecFormatter
    RSpec::Core::Formatters.register self

    def initialize(_output)
    end
  end
end
