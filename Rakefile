require 'rubygems' unless defined?(Gem)
require 'bundler'
require 'rake'
require 'rake/testtask'

# by default run unit tests.
task :default => 'test'

desc 'Run full test suite and generate code coverage -- COVERAGE=false to disable code coverage'
Rake::TestTask.new(:test) do |task|
  ENV['COVERAGE'] ||= 'yes'
  task.libs << 'test'
  task.pattern = 'test/**/*_test.rb'
  task.verbose = true
end
