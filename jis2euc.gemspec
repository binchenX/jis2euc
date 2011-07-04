# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jis2euc/version"

Gem::Specification.new do |s|
  s.name        = "jis2euc"
  s.version     = Jis2euc::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["pierr.chen"]
  s.email       = ["pierr.chen@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{convert jis encoding to EUC-JP}
  s.description = %q{ARIB standard combines serveral JIS encoding for texts ,this gem convert them to EUC-JP }

  s.rubyforge_project = "jis2euc"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
