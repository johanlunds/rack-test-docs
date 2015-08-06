require 'spec_helper'

describe RackTestDocs::RSpecFormatter do
  before(:each) do
    FileUtils.mkdir_p "tmp/"
    allow(Rails).to receive(:root).and_return("tmp/")
  end

  after(:each) do
    FileUtils.rm_rf Dir.glob('tmp/*')
  end

  let(:output)               { StringIO.new }
  let(:formatter)            { RackTestDocs::RSpecFormatter.new(output) }
  let(:example)              { RSpec::Core::ExampleGroup.describe.example }
  let(:example_count)        { 2 }
  let(:start_notification)   { RSpec::Core::Notifications::StartNotification.new(example_count, Time.now) }
  let(:example_notification) { RSpec::Core::Notifications::ExampleNotification.for(example) }
  let(:pending_notification) { RSpec::Core::Notifications::ExampleNotification.for(pending_example) }
  let(:failed_notification)  { RSpec::Core::Notifications::ExampleNotification.for(failed_example) }

  let(:failed_example) do
    exception = RuntimeError.new('Test Error')
    exception.set_backtrace [
      "/my/filename.rb:4:in `some_method'",
    ]

    example = RSpec::Core::ExampleGroup.describe.example

    example.metadata[:file_path] = '/my/example/spec.rb'
    example.metadata[:execution_result].status = :failed
    example.metadata[:execution_result].exception = exception

    example
  end

  let(:pending_example) do
    example = RSpec::Core::ExampleGroup.describe.example
    example.metadata[:execution_result].pending_fixed = true
    example
  end

  context 'when it is created' do
    it 'does not start the bar until the formatter is started' do
      formatter.start(start_notification)
    end

    it 'creates a new ProgressBar' do
    end
  end

  context 'when it is started' do
    before { formatter.start(start_notification) }

    it 'sets the total to the number of examples' do
    end

    context 'and no custom options are passed in' do
      it 'sets the format of the bar to the default' do
      end
    end

    context 'and an example pends' do
      before do
        formatter.example_pending(pending_example)
      end

      it 'outputs the proper bar information' do
      end

      context 'and then an example succeeds' do
        before do
          formatter.example_pending(pending_notification)
        end

        it 'outputs the pending bar' do
        end
      end
    end
  end
end