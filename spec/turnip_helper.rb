require 'fileutils'

Dir.glob('spec/steps/**/*_steps.rb') { |f| load f, true }

RSpec.configure do |config|
  config.raise_error_for_unimplemented_steps = true

  config.after(type: :feature) do
    Dir.chdir File.expand_path('../../', __FILE__)
    FileUtils.rm_rf Dir.glob('spec/fixtures/rails_app/spec/requests/*')
  end
end
