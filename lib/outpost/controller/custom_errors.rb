module Outpost
  module Controller
    module CustomErrors
      extend ActiveSupport::Concern
      
      NOT_FOUND_ERROR_CLASSES = [
        ActionController::RoutingError, 
        ActionView::MissingTemplate, 
        ActionController::UnknownController, 
        AbstractController::ActionNotFound, 
        ActiveRecord::RecordNotFound
      ]

      included do
        rescue_from StandardError, with: ->(e) { render_error(500, e) }
        rescue_from *NOT_FOUND_ERROR_CLASSES, with: ->(e) { render_error(404, e) }
      end
      
      #----------------------
      
      def render_error(status, e=StandardError)
        if Rails.application.config.consider_all_requests_local
          raise e
        else
          respond_to do |format|
            format.html { render template: "/errors/error_#{status}", status: status, locals: { error: e } }
            format.xml { render xml: { error: status.to_s }, status: status }
            format.text { render text: status, status: status}
            format.any
          end
        end
      end
    end # CustomErrors
  end
end
