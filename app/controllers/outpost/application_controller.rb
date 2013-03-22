module Outpost
  class ApplicationController < ActionController::Base
    include Outpost::Breadcrumbs
    include Outpost::Controller::Authorization
    include Outpost::Controller::Authentication

    unless Rails.application.config.consider_all_requests_local
      rescue_from StandardError, with: ->(e) { render_error(500, e) }
      rescue_from ActionController::RoutingError, ActionView::MissingTemplate, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: ->(e) { render_error(404, e) }
    end

    abstract!
    protect_from_forgery
    before_filter :root_breadcrumb

    #------------------------
    # Always want to add this link to the Breadcrumbs
    def root_breadcrumb
      breadcrumb "Outpost", outpost_root_path
    end

    #----------------------
    
    def render_error(status, e=StandardError)
      render template: "/errors/error_#{status}", status: status, locals: { errors: e }
    end
  end
end
