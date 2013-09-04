# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'virtus/union/version'

Gem::Specification.new do |spec|
  spec.name          = 'virtus-union'
  spec.version       = Virtus::Union::VERSION
  spec.authors       = ['Florian Gilcher']
  spec.email         = ['florian.gilcher@asquera.de']
  spec.description   = %q{A union type for Virtus embedded values, providing some flexibility in what to put into your fields.}
  spec.summary       = %q{A union type for Virtus embedded values.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'virtus'
end
