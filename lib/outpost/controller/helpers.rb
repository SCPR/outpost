## 
# Outpost::Controller::Helpers
#
module Outpost
  module Controller
    module Helpers
      extend ActiveSupport::Concern
      
      included do
        helper_method :sort_mode, :order, :preference
      end

      attr_reader :order, :sort_mode

      #------------------
      # Adds to the flash[:notice] object, only if
      # the request format is HTML.      
      def notice(message)
        flash[:notice] = message if request.format.html?
      end

      #------------------
      # Access session preferences
      def preference(key)
        session["preference_#{key}"]
      end

      #------------------
      
      private

      #------------------
      # Writer for preference
      def set_preference(key, value)
        session["preference_#{key}"] = value
      end

      #------------------
      # Helper to unset a preference
      def unset_preference(key)
        set_preference(key, nil)
      end
    end # Helpers
  end # Controller
end # Outpost
