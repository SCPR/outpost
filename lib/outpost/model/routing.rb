module Outpost
  module Model
    # Routing
    #
    # Provides easy access to any object's admin paths,
    # and any class's admin paths.
    #
    # These methods are just delegations to your app's routes.
    #
    module Routing
      extend ActiveSupport::Concern
      
      module ClassMethods
        # /outpost/blog_entries/new
        def admin_new_path
          @admin_new_path ||= Rails.application.routes.url_helpers.send(
            "new_outpost_#{self.singular_route_key}_path")
        end
        
        # http://kpcc.org/outpost/blog_entries/new
        def admin_new_url
          @admin_new_url ||= Rails.application.routes.url_helpers.send(
            "new_outpost_#{self.singular_route_key}_url")
        end


        # /outpost/blog_entries
        def admin_index_path
          @admin_index_path ||= Rails.application.routes.url_helpers.send(
            "outpost_#{self.route_key}_path")
        end

        # http://kpcc.org/outpost/blog_entries
        def admin_index_url
          @admin_index_url ||= Rails.application.routes.url_helpers.send(
            "outpost_#{self.route_key}_url")
        end
      end


      # /outpost/blog_entries/20/edit
      def admin_edit_path
        @admin_edit_path ||= Rails.application.routes.url_helpers.send(
          "edit_outpost_#{self.class.singular_route_key}_path", self.id)
      end

      # http://kpcc.org/outpost/blog_entries/20/edit
      def admin_edit_url
        @admin_edit_url ||= Rails.application.routes.url_helpers.send(
          "edit_outpost_#{self.class.singular_route_key}_url", self.id)
      end


      # /outpost/blog_entries/20
      def admin_show_path
        @admin_show_path ||= Rails.application.routes.url_helpers.send(
          "outpost_#{self.class.singular_route_key}_path", self.id)
      end

      # http://kpcc.org/outpost/blog_entries/20
      def admin_show_url
        @admin_show_url ||= Rails.application.routes.url_helpers.send(
          "outpost_#{self.class.singular_route_key}_url", self.id)
      end
      
      # Uses self.class::ROUTE_KEY to generate
      # the front-end path to this object
      # If an object doesn't have a front-end path,
      # do not define a ROUTE_KEY on the class.
      def link_path(options={})
        if self.route_hash.present? && defined?(self.class::ROUTE_KEY)
          Rails.application.routes.url_helpers.send("#{self.class::ROUTE_KEY}_path", options.merge!(self.route_hash))
        end
      end

      # Override this method manually for each model.
      def route_hash
        {}
      end
      
      # http://scpr.org/blogs/2012/...
      def remote_link_path(options={})
        if path = self.link_path(options)
          File.join("http://#{Rails.application.default_url_options[:host]}", path)
        end
      end
    end # Routing
  end # Model
end # Outpost
