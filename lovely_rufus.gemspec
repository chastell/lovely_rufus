require 'English'
require 'pathname'

Gem::Specification.new do |gem|
  gem.author      = 'Piotr Szotkowski'
  gem.description = 'An executable and a Ruby library for wrapping ' \
                    'paragraphs of text.'
  gem.email       = 'chastell@chastell.net'
  gem.homepage    = 'http://github.com/chastell/lovely_rufus'
  gem.license     = 'AGPL-3.0'
  gem.name        = 'lovely_rufus'
  gem.summary     = 'lovely_rufus: text wrapper'
  gem.version     = '1.0.1'

  gem.required_ruby_version = '~> 2.7'

  gem.files       = `git ls-files -z`.split("\0")
  gem.executables = gem.files.grep(%r{^bin/}).map { |path| File.basename(path) }

  gem.cert_chain  = ['certs/chastell.pem']
  if Pathname.new($PROGRAM_NAME).basename == Pathname.new('gem')
    gem.signing_key = Pathname.new('~/.ssh/gem-private_key.pem').expand_path
  end

  gem.add_development_dependency 'bogus',          '~> 0.1.4'
  gem.add_development_dependency 'minitest',       '~> 5.6', '< 5.19'
  gem.add_development_dependency 'minitest-focus', '~> 1.1'
  gem.add_development_dependency 'rake',           '~> 13.0'
  gem.add_development_dependency 'reek',           '~> 6.0'
  gem.add_development_dependency 'rubocop',        '~> 1.0'

  gem.metadata['rubygems_mfa_required'] = 'true'
end
