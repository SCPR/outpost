module Outpost
  class ApplicationController < ActionController::Base
    include Outpost::Breadcrumbs
    include Outpost::Controller::Authorization
    include Outpost::Controller::Authentication

    rescue_from StandardError, with: ->(e) { render_error(500, e) }
    rescue_from ActionController::RoutingError, ActionView::MissingTemplate, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: ->(e) { render_error(404, e) }

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

    #----------------------
    
    def render_error(status, e=StandardError)
      if Rails.application.config.consider_all_requests_local
        raise e
      else
        render template: "/errors/error_#{status}", status: status, locals: { errors: e }
      end
    end
  end
end
