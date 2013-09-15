require "outpost/engine"

require 'active_record'
require 'action_controller'
require 'action_view'
require 'action_view/helpers/form_builder'

require 'outpost/config'

module Outpost
  extend ActiveSupport::Autoload
  
  OBJ_KEY_REGEX = %r{([^-]+)-(\d+)}

  autoload :Controller
  autoload :Model
  autoload :Hook
  autoload :Helpers
  autoload :List
  autoload :Breadcrumb, 'outpost/breadcrumbs'
  autoload :Breadcrumbs

  class << self
    attr_writer :config
    def config
      @config ||= Outpost::Config.new
    end

    # TODO can we cache this in development?
    def user_class
      config.user_class.constantize
    end

    #--------------------
    # Convert key from "app/model:id" to AppModel.find_by_id(id)
    def obj_by_key(key)
      if match = match_key(key)
        model = model_classes[match[1]]
        model.find_by_id(match[2]) if model
      end
    end

    #--------------------
    # Same as #obj_by_key, but raises ActiveRecord::RecordNotFound
    # if no object is found or if key doesn't match.
    def obj_by_key!(key)
      obj_by_key(key) or raise ActiveRecord::RecordNotFound
    end


    private

    def match_key(key)
      key.to_s.match(OBJ_KEY_REGEX)
    end

    #--------------------
    
    def model_classes
      @model_classes ||= begin
        klasses = {}
        
        Outpost.config.registered_models.each do |name|
          klass = name.constantize
          klasses.merge!(klass.content_key => klass)
        end
        
        klasses
      end
    end
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, Outpost::Model
end

if defined?(ActionController::Base)
  ActionController::Base.send :include, Outpost::Controller
end
