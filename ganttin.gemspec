# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ganttin/version'

Gem::Specification.new do |spec|
  spec.name          = "ganttin"
  spec.version       = Ganttin::VERSION
  spec.authors       = ["Sergey Besedin"]
  spec.email         = ["kr3ssh@gmail.com"]

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency             'rails', '~> 4.2.0'
  spec.add_dependency             'pg'
  spec.add_dependency             'draper'
  spec.add_dependency             'will_paginate'
  spec.add_dependency             'rabl-rails'
  spec.add_dependency             'grape'
  spec.add_dependency             'hashie-forbidden_attributes'
  spec.add_dependency             'grape-rabl'
  spec.add_dependency             'grape-swagger-rails'
  spec.add_dependency             'devise'
  spec.add_dependency             'pry-rails'
  spec.add_dependency             'valid_email'
  spec.add_dependency             'ransack'
  spec.add_dependency             'has_unique_identifier'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'shoulda-matchers', '~> 3.0'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'factory_girl_rails'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rspec-mocks'
  spec.add_development_dependency 'json_spec'
end
