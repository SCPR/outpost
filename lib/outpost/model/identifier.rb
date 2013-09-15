##
# Identifier
#
# Some unique keys which can be used for routing
# and APIs
module Outpost
  module Model
    module Identifier
      extend ActiveSupport::Concern

      OBJ_KEY_SEPARATOR = "-"

      module ClassMethods
        def content_key
          self.name.tableize.singularize
        end

        def obj_key(id)
          [self.content_key, id || "new"].join(OBJ_KEY_SEPARATOR)
        end

        def new_obj_key
          obj_key(nil)
        end

        # Wrappers for ActiveModel::Naming
        # NewsStory => news_stories
        def route_key
          ActiveModel::Naming.route_key(self)
        end

        # NewsStory => news_story
        def singular_route_key
          ActiveModel::Naming.singular_route_key(self)
        end
      end

      # Default obj_key pattern
      def obj_key
        @obj_key ||= self.class.obj_key(self.id)
      end
    end # Identifier
  end # Model
end # Outpost
