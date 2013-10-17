module Outpost
  module Model
    # Routing
    #
    # Provides easy access to any object's admin paths,
    # and any class's admin paths.
    #
    # These methods are just delegations to your app's routes.
    #
    # Provides alias methods for non-GET routes:
    #
    # * admin_index_path => admin_create_path
    # * admin_show_path  => admin_update_path, admin_destroy_path
    #
    # So you can do, for example:
    #
    #   POST admin_create_path
    #
    # Which would make more sense than `POST admin_index_path`,
    # even though they are the same path.
    module Routing
      extend ActiveSupport::Concern

      module ClassMethods
        # /outpost/blog_entries/new
        def admin_new_path
          collection_route("new_outpost_#{self.singular_route_key}_path")
        end

        # http://kpcc.org/outpost/blog_entries/new
        def admin_new_url
          collection_route("new_outpost_#{self.singular_route_key}_url")
        end


        # /outpost/blog_entries
        def admin_index_path
          collection_route("outpost_#{self.route_key}_path")
        end

        alias_method :admin_create_path, :admin_index_path

        # http://kpcc.org/outpost/blog_entries
        def admin_index_url
          collection_route("outpost_#{self.route_key}_url")
        end

        alias_method :admin_create_url, :admin_index_url


        private

        def collection_route(name)
          Rails.application.routes.url_helpers.send(name)
        end
      end


      # /outpost/blog_entries/20/edit
      def admin_edit_path
          member_route("edit_outpost_#{self.class.singular_route_key}_path")
      end

      # http://kpcc.org/outpost/blog_entries/20/edit
      def admin_edit_url
        member_route("edit_outpost_#{self.class.singular_route_key}_url")
      end


      # /outpost/blog_entries/20
      def admin_show_path
        member_route("outpost_#{self.class.singular_route_key}_path")
      end

      alias_method :admin_update_path, :admin_show_path
      alias_method :admin_destroy_path, :admin_show_path

      # http://kpcc.org/outpost/blog_entries/20
      def admin_show_url
        member_route("outpost_#{self.class.singular_route_key}_url")
      end

      alias_method :admin_update_url, :admin_show_url
      alias_method :admin_destroy_url, :admin_show_url


      # Uses self.class::ROUTE_KEY to generate
      # the front-end path to this object
      # If an object doesn't have a front-end path,
      # do not define a ROUTE_KEY on the class.
      #
      # If the object isn't public, then leave route_hash
      # empty as well.
      def public_path(options={})
        if self.route_hash.present? && defined?(self.class::ROUTE_KEY)
          Rails.application.routes.url_helpers.send(
            "#{self.class::ROUTE_KEY}_path", options.merge!(self.route_hash))
        end
      end

      alias_method :link_path, :public_path
      deprecate link_path: :public_path


      # Override this method manually for each model.
      # If the object isn't public, then don't override
      # this method. #public_path checks for the presence
      # of this object. By leaving it blank, you're also
      # telling #public_path to be nil.
      def route_hash
        {}
      end


      # http://scpr.org/blogs/2012/...
      def public_url(options={})
        if path = self.public_path(options)
          File.join(
            "http://#{Rails.application.default_url_options[:host]}", path)
        end
      end

      alias_method :remote_link_path, :public_url
      deprecate remote_link_path: :public_url


      private

      # Don't try to build a route if the ID is nil.
      # Should we instead be checking persistence?
      def member_route(name)
        if self.id
          Rails.application.routes.url_helpers.send(name, self.id)
        end
      end
    end # Routing
  end # Model
end # Outpost
