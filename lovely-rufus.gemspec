Gem::Specification.new do |gem|
  gem.name     = 'lovely-rufus'
  gem.version  = '0.0.0'
  gem.summary  = 'lovely-rufus: text wrapper'
  gem.homepage = 'http://github.com/chastell/lovely-rufus'
  gem.author   = 'Piotr Szotkowski'
  gem.email    = 'chastell@chastell.net'

  gem.files       = `git ls-files -z`.split "\0"
  gem.executables = Dir['bin/*'].map { |d| d.split '/' }.map &:last
  gem.test_files  = Dir['spec/**/*.rb']
end
