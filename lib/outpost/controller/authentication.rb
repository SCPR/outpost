module Outpost
  module Controller
    module Authentication
      extend ActiveSupport::Concern

      included do
        before_filter :require_login
        helper_method :current_user
      end

      # Public: The currently logged-in user.
      #
      # Returns Outpost.user_class instance.
      def current_user
        begin
          @current_user ||= Outpost.user_class.where(can_login: true).find(session[:user_id])
        rescue ActiveRecord::RecordNotFound
          session[:user_id]   = nil
          @current_user       = nil
        end
      end

      # Private: Callback to require login.
      #
      # Returns nothing.
      def require_login
        if !current_user
          session[:return_to] = request.fullpath
          redirect_to outpost_login_path and return false
        end
      end
    end # Authentication
  end # Controller
end # Outpost
