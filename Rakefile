require 'rake/testtask'

Rake::TestTask.new

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec

task default: :spec

desc 'Run Lovely Rufus console'
task :console do
  require 'irb'
  require_relative 'lib/lovely-rufus'
  include LovelyRufus
  ARGV.clear
  IRB.start
end
