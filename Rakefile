require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

desc "Run specs"
RSpec::Core::RakeTask.new

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :default => :spec