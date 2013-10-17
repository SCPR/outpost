module Outpost
  module Controller
    module CustomErrors
      extend ActiveSupport::Concern

      NOT_FOUND_ERROR_CLASSES = [
        ActionController::RoutingError,
        ActionController::UnknownController,
        AbstractController::ActionNotFound,
        ActiveRecord::RecordNotFound
      ]

      if defined?(ActionController::UnknownFormat)
        NOT_FOUND_ERROR_CLASSES << ActionController::UnknownFormat
      end

      included do
        rescue_from StandardError,
          with: ->(e) { render_error(500, e) and return false }

        rescue_from *NOT_FOUND_ERROR_CLASSES,
          with: ->(e) { render_error(404, e) and return false }
      end

      #----------------------

      def render_error(status, e=StandardError)
        response.status = status

        if Rails.application.config.consider_all_requests_local
          raise e
        else
          respond_to do |format|
            format.html do
              render(
                :template   => "/errors/error_#{status}",
                :layout     => "application",
                :status     => status,
                :locals     => { error: e }
              )
            end

            format.xml do
              render xml: {
                :error    => response.message,
                :code     => status
              }, status: status
            end

            format.json do
              render json: {
                :error    => response.message,
                :code     => status
              }, status: status
            end

            format.text do
              render(
                :text     => "#{status} - #{response.message}",
                :status   => status
              )
            end

            format.any do
              head status
            end
          end
        end
      end
    end
  end
end
