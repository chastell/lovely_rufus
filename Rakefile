require 'rake/testtask'
require 'reek/rake/task'
require 'rubocop/rake_task'

task default: %i[spec rubocop reek]

Rake::TestTask.new :spec do |task|
  task.test_files = FileList['spec/**/*_spec.rb']
  task.warning    = true
end

Reek::Rake::Task.new do |task|
  task.config_files  = 'config/reek.yml'
  task.fail_on_error = false
  task.reek_opts     = '--quiet'
end

Rubocop::RakeTask.new
