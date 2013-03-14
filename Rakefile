#!/usr/bin/env rake
require 'bundler/setup'
require 'rdoc/task'
require 'rspec/core/rake_task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Outpost'
  rdoc.markup   = 'tomdoc'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.rdoc_files.include('app/helpers/**/*.rb')
  rdoc.rdoc_files.include('app/models/**/*.rb')
end

Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each { |f| load f }

RSpec::Core::RakeTask.new(:test)
task :default => :test
