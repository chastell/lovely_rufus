require 'English'
require 'pathname'

Gem::Specification.new do |gem|
  gem.author      = 'Piotr Szotkowski'
  gem.description = 'An executable and a Ruby library for wrapping ' \
                    'paragraphs of text.'
  gem.email       = 'chastell@chastell.net'
  gem.homepage    = 'http://github.com/chastell/lovely_rufus'
  gem.license     = 'AGPL-3.0-or-later'
  gem.name        = 'lovely_rufus'
  gem.summary     = 'lovely_rufus: text wrapper'
  gem.version     = '1.3.0'

  gem.required_ruby_version = '~> 3.2'

  gem.files       = `git ls-files -z`.split("\0")
  gem.executables = gem.files.grep(%r{^bin/}).map { |path| File.basename(path) }

  gem.add_development_dependency 'minitest',       '~> 5.6'
  gem.add_development_dependency 'minitest-focus', '~> 1.1'
  gem.add_development_dependency 'mocha',          '~> 2.7'
  gem.add_development_dependency 'rake',           '~> 13.0'
  gem.add_development_dependency 'reek',           '~> 6.0'
  gem.add_development_dependency 'rubocop',        '~> 1.0'

  gem.metadata['rubygems_mfa_required'] = 'true'
end
