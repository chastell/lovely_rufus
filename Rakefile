require 'rake/testtask'
require 'reek/rake/task'
require 'rubocop/rake_task'

task default: %i(test rubocop reek)

Rake::TestTask.new do |task|
  task.pattern = 'test/**/*_test.rb'
  task.warning = true
end

Reek::Rake::Task.new do |task|
  task.fail_on_error = false
end

RuboCop::RakeTask.new do |task|
  task.options << '--display-cop-names'
end
