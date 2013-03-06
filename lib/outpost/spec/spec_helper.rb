# ADMIN RESOURCE SPEC HELPER
ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require File.expand_path("../../../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'chronic'
require 'fakeweb'
require 'database_cleaner'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("lib/outpost/spec/db/*.rb")].each  { |f| require f }

FakeWeb.allow_net_connect = false

RSpec.configure do |config|  
  config.use_transactional_fixtures                 = false
  config.infer_base_class_for_anonymous_controllers = true
    
  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
    ActiveRecord::Base.establish_connection("isolated")
    migration = -> { OutpostMigration.new.up }
    silence_stream STDOUT, &migration
    Dir[Rails.root.join("lib/outpost/spec/test_classes/*.rb")].each { |f| load f }
  end
  
  config.before do
    DatabaseCleaner.start
  end
  
  config.after do
    DatabaseCleaner.clean
  end
end
