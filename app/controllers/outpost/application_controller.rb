module Outpost
  class ApplicationController < ActionController::Base
    include Outpost::Breadcrumbs
    include Outpost::Controller::Authorization
    include Outpost::Controller::Authentication
    include Outpost::Controller::CustomErrors
    
    abstract!
    protect_from_forgery
    before_filter :root_breadcrumb
    before_filter :set_sections

    #------------------------
    # Always want to add this link to the Breadcrumbs
    def root_breadcrumb
      breadcrumb "Outpost", outpost_root_path
    end

    #----------------------

    def set_sections
      @sections = {}
    end
  end
end
