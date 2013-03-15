##
# Authorization
#
# Basic authorization methods for controllers
module Outpost
  module Controller
    module Authorization
      # Make sure the user can authorize the current resource
      def authorize!(resource=nil)
        resource ||= Outpost::Helpers::Naming.to_class(params[:controller])
        
        if !current_user.can_manage?(resource)
          handle_unauthorized(resource)
        end
      end

      # What to do when a user doesn't have proper permissions
      def handle_unauthorized(resource)
        redirect_to root_path, alert: "You don't have permission to manage #{resource.to_title.pluralize}"
        return false
      end
    end # Authorization
  end # Controller
end # Outpost
