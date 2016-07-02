# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "css_dead_class"
  s.version     = "1.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Pilsch"]
  s.email       = ["apilsch@tamu.edu"]
  s.homepage    = "https://github.com/oncomouse/css_dead_class"
  s.summary     = %q{Gem that, given a collection of HTML documents and CSS files, will remove any class attributes in the HTML set to CSS selectors that do not exist in the CSS files.}
  # s.description = %q{A longer description of your extension}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("nokogiri", ["~> 1.6"])
  s.add_runtime_dependency("css_parser", ["~> 1.4"])
  
  s.license = "ISC"
  
  # Additional dependencies
  # s.add_runtime_dependency("gem-name", "gem-version")
end
