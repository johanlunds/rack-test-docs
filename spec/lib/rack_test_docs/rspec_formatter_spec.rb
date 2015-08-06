describe RackTestDocs::RSpecFormatter do
  let(:output)               { StringIO.new }
  let(:formatter)            { RackTestDocs::RSpecFormatter.new(output) }
  let(:example)              { RSpec::Core::ExampleGroup.describe.example }
  let(:example_count)        { 2 }
  let(:start_notification)   { RSpec::Core::Notifications::StartNotification.new(example_count, Time.now) }
  let(:example_notification) { RSpec::Core::Notifications::ExampleNotification.for(example) }
  let(:pending_notification) { RSpec::Core::Notifications::ExampleNotification.for(pending_example) }
  let(:failed_notification)  { RSpec::Core::Notifications::ExampleNotification.for(failed_example) }

  let(:failed_example) do
    exception = RuntimeError.new('Test Fuubar Error')
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

  let(:fuubar_results) do
    output.rewind
    output.read
  end

  context 'when it is created' do
    it 'does not start the bar until the formatter is started' do
      expect(formatter.progress).not_to be_started

      formatter.start(start_notification)

      expect(formatter.progress).to be_started
    end

    it 'creates a new ProgressBar' do
      expect(formatter.progress).to be_instance_of ProgressBar::Base
    end
  end

  context 'when it is started' do
    before { formatter.start(start_notification) }

    it 'sets the total to the number of examples' do
      expect(formatter.progress.total).to eql 2
    end

    context 'and no custom options are passed in' do
      it 'sets the format of the bar to the default' do
        expect(formatter.progress.instance_variable_get(:@format_string)).to eql ' %c/%C |%w>%i| %e '
      end
    end

    context 'and an example pends' do
      before do
        output.rewind

        formatter.example_pending(pending_example)
      end

      it 'outputs the proper bar information' do
        formatter.progress.increment
        expect(fuubar_results).to start_with "\e[33m 1/2 |== 50 ==>        |  ETA: 00:00:00 \r\e[0m"
      end

      context 'and then an example succeeds' do
        before do
          output.rewind

          formatter.example_pending(pending_notification)
        end

        it 'outputs the pending bar' do
          expect(fuubar_results).to start_with "\e[33m 2/2 |===== 100 ======>| Time: 00:00:00 \n\e[0m"
        end
      end
    end
  end
end