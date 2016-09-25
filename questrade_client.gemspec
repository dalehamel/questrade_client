# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'questrade_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'questrade_client'
  spec.version       = QuestradeClient::VERSION
  spec.authors       = ['Dale Hamel']
  spec.email         = ['daleha@gmail.com']

  spec.summary       = 'Ruby client library for the Questrade API'
  spec.homepage      = 'https://github.com/dalehamel/questrade_client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 1.21.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop', '~> 0.39.0'
  spec.add_development_dependency 'simplecov', ['=0.10.0']

  spec.add_dependency 'faraday', '~> 0.9.0'
  spec.add_dependency 'faraday_middleware', '~> 0.9.0'
  spec.add_dependency 'hashie', '~> 3.0'
end
