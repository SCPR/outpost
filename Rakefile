#!/usr/bin/env rake
RAKED = true

require 'bundler/setup'
require 'rspec/core/rake_task'
require 'combustion'

Bundler::GemHelper.install_tasks
Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each { |f| load f }

Bundler.require :default, :test
Combustion.initialize! :active_record, :action_controller
Combustion::Application.load_tasks

RSpec::Core::RakeTask.new(:test)
