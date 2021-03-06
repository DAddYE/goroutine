# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'goroutine/version'

Gem::Specification.new do |spec|
  spec.name          = "goroutine"
  spec.version       = Goroutine::VERSION
  spec.authors       = ["Davide D'Agostino"]
  spec.email         = ["info@daddye.it"]
  spec.summary       = %q{A simple goroutine model for ruby.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/DAddYE/goroutine"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
