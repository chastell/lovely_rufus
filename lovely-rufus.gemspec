Gem::Specification.new do |gem|
  gem.name     = 'lovely-rufus'
  gem.version  = '0.0.2'
  gem.summary  = 'lovely-rufus: text wrapper'
  gem.homepage = 'http://github.com/chastell/lovely-rufus'
  gem.author   = 'Piotr Szotkowski'
  gem.email    = 'chastell@chastell.net'

  gem.files       = `git ls-files -z`.split "\0"
  gem.executables = `git ls-files -z -- bin/*`.split("\0").map { |file| File.basename file }
  gem.test_files  = `git ls-files -z -- spec/*`.split "\0"

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'minitest', '>= 2.3'
  gem.add_development_dependency 'rake'
end
