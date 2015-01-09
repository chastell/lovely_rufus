require 'rake/testtask'
require 'reek/rake/task'
require 'rubocop/rake_task'

# https://github.com/mbj/unparser/issues/33
unparser = Gem::Specification.find { |spec| spec.name == 'unparser' }
if unparser.version > Gem::Version.new('0.1.16')
  fail 'add reek to default task again and see whether it works now'
end
task default: %i(test rubocop)

Rake::TestTask.new do |task|
  task.pattern = 'test/**/*_test.rb'
  task.warning = true
end

Reek::Rake::Task.new do |task|
  task.config_files  = 'config/reek.yml'
  task.fail_on_error = false
  task.reek_opts     = '--quiet'
end

RuboCop::RakeTask.new do |task|
  task.options << '--display-cop-names'
end
