step "I am currently in my example Rails-app" do
  Dir.chdir("spec/fixtures/rails_app")
end

step "a file named :filename with the contents:" do |filename, contents|
  IO.write(filename, contents)
end

step "I run `rspec`" do
  @zero_exit_status = system "rspec"
end

step "all tests should pass" do
  expect(@zero_exit_status).to be_true
end

step "a file should exist at :filename with the contents:" do |filename, contents|
  expect(File.exist?(filename)).to be_true
  expect(IO.read(filename)).to eq(contents)
end
