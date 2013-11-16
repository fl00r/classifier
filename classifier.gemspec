# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'classifier/version'

Gem::Specification.new do |spec|
  spec.name          = "classifier"
  spec.version       = Classifier::VERSION
  spec.authors       = ["Peter Yanovich"]
  spec.email         = ["fl00r@yandex.ru"]
  spec.description   = %q{Bayes and maximum entropy classifiers}
  spec.summary       = %q{Naive Bayes classifier and Principle of maximum entropy classifier implementations on Ruby.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "unicode"
end
