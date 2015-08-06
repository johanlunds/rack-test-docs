Dir.glob("spec/steps/**/*_steps.rb") { |f| load f, true }

RSpec.configure do |config|
  config.raise_error_for_unimplemented_steps = true
end