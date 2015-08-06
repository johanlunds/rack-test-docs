step "I am currently in my example Rails-app" do
  Dir.chdir("spec/fixtures/rails_app")
end

step "a file named :filename with the contents:" do |filename, contents|
  IO.write(filename, contents)
end

step "I run `rspec`" do
  @rspec_output = `rspec 2>&1`
  @exit_status = $?.exitstatus
end

step "all tests should pass" do
  expect(@exit_status).to eq(0), "expected rspec to exit successfully, but got output:\n#{@rspec_output}"
end

step "a file should exist at :filename with the contents:" do |filename, contents|
  expect(File.exist?(filename)).to be true
  expect(IO.read(filename)).to eq(contents)
end
