##
# Outpost::Model
module Outpost
  module Model
    extend ActiveSupport::Concern
    extend ActiveSupport::Autoload

    autoload :Authentication
    autoload :Authorization
    autoload :Methods
    autoload :Identifier
    autoload :Routing
    autoload :Naming
    autoload :Serializer

    module ClassMethods
      def outpost_model(options={})
        include Methods, Identifier, Routing, Naming, Serializer

        # Convenience for setting options on the class.
        options.each do |option, value|
          send("#{option}=", value)
        end
      end
    end # ClassMethods
  end # Model
end # Outpost
