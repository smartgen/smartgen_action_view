# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "smartgen_action_view/version"

Gem::Specification.new do |s|
  s.name        = "smartgen_action_view"
  s.version     = SmartgenActionView::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Vicente Mundim"]
  s.email       = ["vicente.mundim@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Use ActionView to render files in smartgen}
  s.description = %q{This gem gives you all the power of ActionView when rendering files in smartgen, such as using partials, helpers, etc.}

  s.rubyforge_project = "smartgen_action_view"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  
  s.require_paths = ["lib"]
  
  s.add_dependency "smartgen", "~> 0.6.0.beta"
  s.add_dependency "actionpack", ">= 3.0.4"

  s.add_development_dependency "rspec", ">= 2.3.0"
end
