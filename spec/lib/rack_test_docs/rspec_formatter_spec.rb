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
  let(:example_group)        do
    group = RSpec::Core::ExampleGroup.describe
    group.metadata.merge!({
      :execution_result=>nil, # #<RSpec::Core::Example::ExecutionResult:0x007fa96f8aa8c0>
      :block=> nil, # #<Proc:0x007fa96f8aae60@/Users/johan_lunds/Documents/Kod/rack-test-docs/spec/fixtures/rails_app/spec/requests/posts_requests_spec.rb:3>
      :description_args=>["Posts REST API"],
      :description=>"Posts REST API",
      :full_description=>"Posts REST API",
      :described_class=>nil,
      :file_path=>"./spec/requests/posts_requests_spec.rb",
      :line_number=>3,
      :location=>"./spec/requests/posts_requests_spec.rb:3",
      :absolute_file_path=>
       "/Users/johan_lunds/Documents/Kod/rack-test-docs/spec/fixtures/rails_app/spec/requests/posts_requests_spec.rb",
      :rerun_file_path=>"./spec/requests/posts_requests_spec.rb",
      :scoped_id=>"1",
      :type=>:request}
      )
    group
  end
  let(:sub_example_group) do
    group = example_group.describe
    group.metadata.merge!({
      :execution_result=> nil , # #<RSpec::Core::Example::ExecutionResult:0x007fe14e181988>
      :block=> nil, # #<Proc:0x007fe14e181be0@/Users/johan_lunds/Documents/Kod/rack-test-docs/spec/fixtures/rails_app/spec/requests/posts_requests_spec.rb:4>
      :description_args=>["GET /posts"],
      :description=>"GET /posts",
      :full_description=>"Posts REST API GET /posts",
      :described_class=>nil,
      :file_path=>"./spec/requests/posts_requests_spec.rb",
      :line_number=>4,
      :location=>"./spec/requests/posts_requests_spec.rb:4",
      :absolute_file_path=>
       "/Users/johan_lunds/Documents/Kod/rack-test-docs/spec/fixtures/rails_app/spec/requests/posts_requests_spec.rb",
      :rerun_file_path=>"./spec/requests/posts_requests_spec.rb",
      :scoped_id=>"1:1",
      :type=>:request,
      :parent_example_group=> example_group.metadata}
      )
    group
  end
  let(:example) do
    example = sub_example_group.example
    example.metadata.merge!({
      :execution_result=>nil, # #<RSpec::Core::Example::ExecutionResult:0x007fa96f9bc7b8>
      :block=> nil,  # #<Proc:0x007fa96f9bca60@/Users/johan_lunds/Documents/Kod/rack-test-docs/spec/fixtures/rails_app/spec/requests/posts_requests_spec.rb:5>
      :description_args=>["returns all posts"],
      :description=>"returns all posts",
      :full_description=>"Posts REST API GET /posts returns all posts",
      :described_class=>nil,
      :file_path=>"./spec/requests/posts_requests_spec.rb",
      :line_number=>5,
      :location=>"./spec/requests/posts_requests_spec.rb:5",
      :absolute_file_path=>
       "/Users/johan_lunds/Documents/Kod/rack-test-docs/spec/fixtures/rails_app/spec/requests/posts_requests_spec.rb",
      :rerun_file_path=>"./spec/requests/posts_requests_spec.rb",
      :scoped_id=>"1:1:1",
      :type=>:request,
      :example_group => sub_example_group.metadata,
      :shared_group_inclusion_backtrace => [],
      :last_run_status=>"unknown"}
      )
    example
  end
  let(:start_notification)   { RSpec::Core::Notifications::StartNotification.new(count: 2, load_time: 1.898042) }
  let(:group_notification)   { RSpec::Core::Notifications::GroupNotification.new(group: example_group) }
  let(:sub_group_notification)   { RSpec::Core::Notifications::GroupNotification.new(group: sub_example_group) }
  let(:example_notification) { RSpec::Core::Notifications::ExampleNotification.for(example) }
  let(:pending_notification) { RSpec::Core::Notifications::ExampleNotification.for(pending_example) }
  let(:failed_notification)  { RSpec::Core::Notifications::ExampleNotification.for(failed_example) }
  let(:stop_notification)  do
    # TODO
    # RSpec::Core::Notifications::ExamplesNotification
  end
  let(:summary_notification)  do
    # TODO
    # RSpec::Core::Notifications::SummaryNotification
  end
  let(:close_notification) { RSpec::Core::Notifications::NullNotification.new }

  let(:failed_example) do
    exception = RuntimeError.new('Test Error')
    exception.set_backtrace [
      "/my/filename.rb:4:in `some_method'",
    ]

    example = sub_example_group.example

    example.metadata[:file_path] = './spec/requests/posts_requests_spec.rb'
    example.metadata[:execution_result].status = :failed
    example.metadata[:execution_result].exception = exception

    example
  end

  let(:pending_example) do
    example = sub_example_group.example
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