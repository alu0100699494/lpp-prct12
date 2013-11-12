# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'math_expansion/version'

Gem::Specification.new do |spec|
  spec.name          = "math_expansion"
  spec.version       = MathExpansion::VERSION
  spec.authors       = ["Eliasib Garcia","Daniel Herzog"]
  spec.email         = ["alu0100698121@ull.edu.es","alu0100699494"]
  spec.description   = %q{Permite la creación y uso de matrices densas y dispersas.}
  spec.summary       = %q{Matrices densas y dispersas}
  spec.homepage      = "https://github.com/alu0100698121/prct09.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
