# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitstamp/version'

Gem::Specification.new do |spec|
  # For explanations see http://docs.rubygems.org/read/chapter/20
  spec.name          = "bitstamp-client"
  spec.version       = Bitstamp::VERSION
  spec.authors       = ["Tobias Schoknecht"]
  spec.email         = ["tobias.schoknecht@gmail.com"]
  spec.description   = %q{Bitstamp Exchange API Client}
  spec.summary       = %q{Very generic client for REST API with basic error handling}
  spec.homepage      = 'https://github.com/tobischo/bitstamp'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rake',      '~> 12.3', '>= 12.3.0'
  spec.add_development_dependency 'rspec',     '~> 3.7', '>= 3.7.0'
  spec.add_development_dependency 'builder',   '~> 3.2', '>= 3.2.3'
  spec.add_development_dependency 'rack-test', '~> 0.8.2'

  spec.add_dependency 'typhoeus',  '~> 1.3', '>= 1.3.0'
end
