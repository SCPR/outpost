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


    private

    #----------------------
    # This method was originally introduced to get around
    # a kaminari bug: https://github.com/amatsuda/kaminari/issues/457
    # But it could stick around and be useful anyways.
    def route_proxy
      nil
    end
    helper_method :route_proxy

    #------------------------
    # Always want to add this link to the Breadcrumbs
    def root_breadcrumb
      breadcrumb "Outpost", outpost.root_path
    end

    #----------------------

    def set_sections
      @sections = {}
    end

    def with_rollback(object)
      object.transaction do
        yield if block_given?
        raise ActiveRecord::Rollback
      end
    end

    #----------------------

    def render_preview_validation_errors(record)
      render "/outpost/shared/_preview_errors",
        :layout => "outpost/minimal",
        :locals => { record: record }
    end
  end
end
