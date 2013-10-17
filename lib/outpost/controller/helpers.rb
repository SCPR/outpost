## 
# Outpost::Controller::Helpers
module Outpost
  module Controller
    module Helpers
      extend ActiveSupport::Concern

      # Public: Set the flash[:notice] message, only for HTML requests.
      #
      # message - (String) The message to add to the flash.
      #
      # Examples
      #
      #   notice("Success")
      #   flash[:notice]
      #   # => "Success"
      #
      # Returns nothing.
      def notice(message)
        flash[:notice] = message if request.format.html?
      end
    end # Helpers
  end # Controller
end # Outpost
