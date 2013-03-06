##
# Identifier
#
# Some unique keys which can be used for routing
# and APIs
#
module Outpost
  module Model
    module Identifier
      extend ActiveSupport::Concern

      #-------------
      
      module ClassMethods
        def content_key
          if self.respond_to? :table_name
            self.table_name.gsub(/_/, "/")
          else
            self.name.tableize
          end
        end
        
        #--------------
        # Wrappers for ActiveModel::Naming
        # NewsStory => news_stories
        def route_key
          @route_key ||= ActiveModel::Naming.route_key(self)
        end
        
        #--------------
        # NewsStory => news_story
        def singular_route_key
          @singular_route_key ||= ActiveModel::Naming.singular_route_key(self)
        end
      end
      
      #-------------
      # Default obj_key pattern
      def obj_key
        @obj_key ||= [self.class.content_key,self.id || "new"].join(":")
      end
    end # Identifier
  end # Model
end # Outpost
