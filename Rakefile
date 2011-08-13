require 'rake/testtask'

Rake::TestTask.new do |task|
  task.test_files = FileList['test/**/*_spec.rb']
end

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
