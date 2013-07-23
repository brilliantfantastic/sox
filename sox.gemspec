# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sox/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors     = ['Jamie Wright',                 'Keith Thompson']
  gem.email       = ['jamie@brilliantfantastic.com', 'keith@brilliantfantastic.com']
  gem.description = 'A RubyMotion wrapper for the Freshbooks API'
  gem.summary     = 'A RubyMotion wrapper for the Freshbooks API'

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|lib_spec|features)/})
  gem.name          = 'sox'
  gem.require_paths = ['lib']
  gem.version       = Sox::VERSION

  gem.add_dependency 'bubble-wrap', '~> 1.3.0'

  gem.add_development_dependency 'bacon'
  gem.add_development_dependency 'rake'
end
