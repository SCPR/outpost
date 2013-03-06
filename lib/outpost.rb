##
# Outpost
require "outpost/engine"
require 'active_record'
require 'action_controller'
require 'outpost/config'

module Outpost
  extend ActiveSupport::Autoload
  
  autoload :Controller
  autoload :Model
  autoload :Hook
  autoload :Helpers
  autoload :List
  autoload :Breadcrumbs

  #----------------------

  class << self
    attr_writer :config
    def config
      @config || Outpost::Config.configure
    end
  end
end

#----------------------

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, Outpost::Model
end

#----------------------

if defined?(ActionController::Base)
  ActionController::Base.send :include, Outpost::Controller
end
