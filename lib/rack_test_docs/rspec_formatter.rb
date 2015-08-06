module RackTestDocs
  class RSpecFormatter
    # A reference of the individual events:
    # https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/formatters/protocol.rb
    RSpec::Core::Formatters.register self, :start, :example_group_started, :example_group_finished, :example_started,
                                     :example_finished, :example_passed, :example_pending, :example_failed, :stop,
                                     :dump_summary, :close

    def initialize(_output)
      @app_root = Rails.root
    end

    def start(_notification)
      FileUtils.mkdir_p File.join(@app_root, "docs", "requests")
    end

    def example_group_started(_notification)
    end

    def example_group_finished(_notification)
    end

    def example_started(_notification)
    end

    def example_finished(_notification)
    end

    def example_passed(_notification)
    end

    def example_pending(_notification)
    end

    def example_failed(_notification)
    end

    def stop(_notification)
    end

    def dump_summary(_notification)
    end

    def close(_notification)
    end

  end
end
