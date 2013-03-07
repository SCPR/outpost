##
# Authentication
#
# Basic authentication methods for controllers
module Outpost
  module Controller
    module Authentication
      extend ActiveSupport::Concern

      included do
        before_filter :require_admin
      end

      def require_admin
        # Only allow in if admin_user is set
        if !admin_user
          session[:return_to] = request.fullpath
          redirect_to admin_login_path and return false
        end
      end
    end # Authentication
  end # Controller
end # Outpost
