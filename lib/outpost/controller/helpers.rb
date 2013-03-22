## 
# Outpost::Controller::Helpers
module Outpost
  module Controller
    module Helpers
      extend ActiveSupport::Concern
      include Outpost::Controller::Ordering
      
      included do
        helper_method :sort_mode, :order
      end

      # Public: The order that the records are currently sorted by.
      # This gets passed directly to ActiveRecord, so it should be
      # a valid database order.
      #
      # Returns String of the order.
      def order
        @order ||= set_order
      end

      # Public: The sort mode that the records are currently sorted by.
      # This gets passed directory to ActiveRecord, so it should be
      # a valid database sort mode.
      #
      # Examples
      #
      #   sort_mode
      #   # => "asc"
      #
      # Returns String of the sort mode.
      def sort_mode
        @sort_mode ||= set_sort_mode
      end

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
