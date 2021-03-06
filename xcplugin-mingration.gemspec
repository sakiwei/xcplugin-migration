# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcplugin-mingration/version'

Gem::Specification.new do |spec|
  spec.name          = "xcplugin-mingration"
  spec.version       = XcpluginMingration::VERSION
  spec.authors       = ["sakiwei"]
  spec.email         = ["sakiwei@gmail.com"]
  spec.description   = "Make your old Xcode plugins be available on the latest Xcode"
  spec.summary       = "Make your old Xcode plugins be available on the latest Xcode"
  spec.homepage      = "http://sakiwei.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "hashie"
  spec.add_dependency "colorize"
  spec.add_dependency "CFPropertyList"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "guard-rspec"
end