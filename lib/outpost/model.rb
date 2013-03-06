##
# Outpost::Model
#
module Outpost
  module Model
    extend ActiveSupport::Concern
    extend ActiveSupport::Autoload
    
    autoload :Methods
    autoload :Identifier
    autoload :Routing
    autoload :Naming
    autoload :Serializer
    
    module ClassMethods
      def outpost_model
        include Methods, Identifier, Routing, Naming, Serializer
      end
    end # ClassMethods
  end # Model
end # Outpost
