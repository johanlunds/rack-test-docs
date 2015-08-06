require 'fileutils'

module RackTestDocs
  class RSpecFormatter
    # A reference of the individual events:
    # https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/formatters/protocol.rb
    RSpec::Core::Formatters.register self, :start, :example_group_started, :example_group_finished, :example_started,
                                     :example_finished, :example_passed, :example_pending, :example_failed, :stop,
                                     :dump_summary, :close

    def initialize(_output)
      @app_root = Rails.root
      @current_file = StringIO.new
    end

    def start(_notification)
      FileUtils.rm_rf File.join(@app_root, "docs", "requests")
      FileUtils.mkdir_p File.join(@app_root, "docs", "requests")
    end

    def example_group_started(notification)
      # TODO: handle describe/context and other block types differently
      # TODO: skip all callbacks unless type == :request
      heading_level = notification.group.metadata[:scoped_id].split(":").length
      @current_file.puts("#{'#' * heading_level} #{notification.group.metadata[:description]}")
      @current_file.puts
    end

    def example_group_finished(notification)
      @current_file.puts

      if notification.group.metadata[:parent_example_group].nil?
        path = notification.group.metadata[:absolute_file_path]
        new_path = path.gsub("/spec/requests/", "/docs/requests/").gsub("_spec.rb", ".md")
        # TODO: make missing dirs if nested paths
        @current_file.rewind
        File.open(new_path, "a") { |f| f.write(@current_file.read) }
        @current_file = StringIO.new
      end
    end

    def example_started(notification)
      heading_level = notification.example.metadata[:scoped_id].split(":").length
      @current_file.puts("#{'#' * heading_level} It #{notification.example.metadata[:description]}")
      @current_file.puts
    end

    def example_finished(_notification)
      @current_file.puts
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
