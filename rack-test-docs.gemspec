# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack_test_docs/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack-test-docs'
  spec.version       = RackTestDocs::VERSION
  spec.authors       = ['Johan Lundström']
  spec.email         = ['johan.lundstrom@fishbrain.com']

  spec.summary       = 'Write a short summary, because Rubygems requires one.' # TODO
  spec.description   = 'Write a longer description or delete this line.' # TODO
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'turnip'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rubocop'
end
