# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "xidl/version"

Gem::Specification.new do |s|
  s.name        = "xidl"
  s.version     = XIDL::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mitchell Hashimoto"]
  s.email       = ["mitchell.hashimoto@gmail.com"]
  s.homepage    = "http://github.com/mitchellh/xidl"
  s.summary     = "Parses XIDL files into Ruby objects."
  s.description = "Parses XIDL files into Ruby objects."

  s.rubyforge_project = "xidl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
