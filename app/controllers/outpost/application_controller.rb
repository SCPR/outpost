module Outpost
  class ApplicationController < ActionController::Base
    include Outpost::Breadcrumbs

    abstract!
    protect_from_forgery

    layout 'outpost'

    before_filter :require_admin
    before_filter :set_sections
    before_filter :root_breadcrumb

    def require_admin
      # Only allow in if admin_user is set
      if !admin_user
        session[:return_to] = request.fullpath
        redirect_to admin_login_path and return false
      end
    end

    #------------------------
    # Always want to add this link to the Breadcrumbs
    def root_breadcrumb
      breadcrumb "Outpost", admin_root_path
    end

    #------------------------
    # Just setup the @sections variable so the views can add to it.
    def set_sections
      @sections = {}
    end

    #------------------------
    # Make sure the user can authorize the current resource
    def authorize!(resource=nil)
      resource ||= Outpost::Helpers::Naming.to_class(params[:controller])
      
      if !admin_user.can_manage?(resource)
        handle_unauthorized(resource)
      end
    end

    #------------------------
    # What to do when a user doesn't have proper permissions
    def handle_unauthorized(resource)
      redirect_to admin_root_path, alert: "You don't have permission to manage #{resource.to_title.pluralize}"
      return false
    end
  end
end
