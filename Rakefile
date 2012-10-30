require 'rake/testtask'

Rake::TestTask.new :spec do |task|
  task.test_files = FileList['spec/**/*_spec.rb']
  task.warning    = true
end

task default: :spec

desc 'Run Lovely Rufus console'
task :console do
  require 'irb'
  require_relative 'lib/lovely-rufus'
  include LovelyRufus
  ARGV.clear
  IRB.start
end
