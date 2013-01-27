# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rivalry/version'

Gem::Specification.new do |gem|
  gem.name          = "rivalry"
  gem.version       = Rivalry::VERSION
  gem.authors       = ["Anthony Cook"]
  gem.email         = ["anthonymichaelcook@gmail.com"]
  gem.description   = %q{The (fast!) duplicate file finder for Ruby! Supports media file and ignoring SCM directories.}
  gem.summary       = %q{The (fast!) duplicate file finder for Ruby!}
  gem.homepage      = "https://github.com/acook/rivalry#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
