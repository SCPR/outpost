module Outpost
  class ApplicationController < ActionController::Base
    include Outpost::Breadcrumbs
    include Outpost::Controller::Authorization
    include Outpost::Controller::Authentication

    abstract!
    protect_from_forgery
    before_filter :root_breadcrumb

    #------------------------
    # Always want to add this link to the Breadcrumbs
    def root_breadcrumb
      breadcrumb "Outpost", outpost_root_path
    end
  end
end
