##
# Authorization
#
# Basic authorization methods for controllers
module Outpost
  module Controller
    module Authorization
      # Make sure the user can authorize the current resource
      def authorize(resource)
        if !current_user.can_manage?(resource)
          handle_unauthorized(resource)
        end
      end

      # Use this for before_filter. Should be overridden for custom behavor.
      def authorize_resource
        authorize(self.class.model)
      end

      # What to do when a user doesn't have proper permissions
      def handle_unauthorized(resource)
        redirect_to outpost_root_path,
          alert: "You don't have permission to manage " \
                 "#{resource.to_title.pluralize}"
        return false
      end
    end # Authorization
  end # Controller
end # Outpost
