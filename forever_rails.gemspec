# -*- encoding: utf-8 -*-
require File.expand_path('../lib/forever_rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Steven Soroka"]
  gem.email         = ["ssoroka78@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "forever_rails"
  gem.require_paths = ["lib"]
  gem.version       = ForeverRails::VERSION
  gem.add_dependency('activesupport', '>=3.0.0')
end
