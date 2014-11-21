Gem::Specification.new do |gem|
  gem.name     = 'lovely-rufus'
  gem.version  = '0.0.5'
  gem.summary  = 'lovely-rufus: text wrapper (legacy gem)'
  gem.homepage = 'http://github.com/chastell/lovely_rufus'
  gem.author   = 'Piotr Szotkowski'
  gem.email    = 'chastell@chastell.net'
  gem.add_dependency 'lovely_rufus'
  gem.add_development_dependency 'minitest', '~> 5.0'
  gem.add_development_dependency 'reek',     '~> 1.3'
  gem.add_development_dependency 'rubocop',  '~> 0.15.0'
end
