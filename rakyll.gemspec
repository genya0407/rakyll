# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rakyll/version'

Gem::Specification.new do |spec|
  spec.name          = "rakyll"
  spec.version       = Rakyll::VERSION
  spec.authors       = ["Yusuke Sangenya"]
  spec.email         = ["longinus.eva@gmail.com"]

  spec.summary       = %q{Static web site generator.}
  spec.description   = %q{Provides DSL to generate static web site easily.}
  spec.homepage      = 'https://github.com/genya0407/rakyll'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "redcarpet", "~> 3.4"
  spec.add_dependency "yaml-front-matter", "~> 0.0.1"
  spec.add_dependency 'rmagick', "~> 2.12"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
