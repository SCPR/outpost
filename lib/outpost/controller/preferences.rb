module Outpost
  module Controller
    module Preferences
      extend ActiveSupport::Concern

      included do
        helper_method :preference
      end

      # Public: Getter for preference.
      # Preferences are stored in the browser's session on a per-resource
      # basis.
      #
      # key - (String) The key for the preference.
      #
      # Examples
      #
      #   preference("posts_order")
      #   # => "updated_at"
      #
      # Returns String of the requested preference.
      def preference(key)
        session["preference_#{key}"]
      end
      
      # Public: Writer for preference.
      #
      # key   - (String) The key to write to.
      # value - (String) The value of the preference.
      #
      # Examples
      #
      #   set_preference("posts_order", "updated_at")
      #   preference("posts_order")
      #   # => "updated_at"
      #
      # Returns nothing. 
      def set_preference(key, value)
        session["preference_#{key}"] = value
      end

      # Public: Unset a preference.
      #
      # key - (String) The key to delete from preferences.
      #
      # Examples
      #
      #   unset_preference("posts_order")
      #   preference("posts_order")
      #   # => nil
      #
      # Returns nothing.
      def unset_preference(key)
        set_preference(key, nil)
      end

      # Remove the preference specified if available
      def remove_preferences
        preferred_sort_mode_key = "#{model.content_key}_sort_mode"
        preferred_order_key     = "#{model.content_key}_order"

        if params[:sort_mode] == "" && preference(preferred_sort_mode_key).present?
          unset_preference(preferred_sort_mode_key)
        end

        if params[:order] == "" && preference(preferred_order_key).present?
          unset_preference(preferred_order_key)
        end
      end
    end
  end
end
