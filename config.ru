require 'rubygems'
require 'bundler'
require 'rails'
require 'combustion'

Bundler.require :default, :development

Combustion.initialize! :all
load Rails.root.join "db", "seeds.rb"

run Combustion::Application
