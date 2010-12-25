require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec

desc 'Run Lovely Rufus console'
task :console do
  require 'irb'
  require_relative 'lib/lovely-rufus'
  include LovelyRufus
  ARGV.clear
  IRB.start
end
