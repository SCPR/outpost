##
# Outpost::Model::Routing
#
# Provides easy access to any object's admin paths,
# and any class's admin paths
#
module Outpost
  module Model
    module Routing
      extend ActiveSupport::Concern
            
      module ClassMethods
        #--------------
        # /admin/blog_entries/new
        def admin_new_path
          @admin_new_path ||= Rails.application.routes.url_helpers.send("new_admin_#{self.singular_route_key}_path")
        end
        
        #--------------
        # /admin/blog_entries
        def admin_index_path
          @admin_index_path ||= Rails.application.routes.url_helpers.send("admin_#{self.route_key}_path")
        end
      end

      #--------------
      #--------------
      # /admin/blog_entries/20/edit
      def admin_edit_path
        @admin_edit_path ||= Rails.application.routes.url_helpers.send("edit_admin_#{self.class.singular_route_key}_path", self.id)
      end

      #--------------
      # /admin/blog_entries/20
      def admin_show_path
        @admin_show_path ||= Rails.application.routes.url_helpers.send("admin_#{self.class.singular_route_key}_path", self.id)
      end
      
      #-------------
      # Uses self.class::ROUTE_KEY to generate
      # the front-end path to this object
      # If an object doesn't have a front-end path,
      # do not define a ROUTE_KEY on the class.
      def link_path(options={})
        if self.route_hash.present? && defined?(self.class::ROUTE_KEY)
          Rails.application.routes.url_helpers.send("#{self.class::ROUTE_KEY}_path", options.merge!(self.route_hash))
        end
      end

      #-------------
      # Override this method manually for each model.
      def route_hash
        {}
      end
      
      #-------------
      # http://scpr.org/blogs/2012/...
      def remote_link_path(options={})
        if path = self.link_path(options)
          File.join("http://#{Rails.application.config.scpr.host}", path)
        end
      end
    end # Routing
  end # Model
end # Outpost
