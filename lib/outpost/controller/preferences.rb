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


      private

      def remove_preferences
        Outpost.config.preferences.each do |preference|
          key = "#{model.content_key}_#{preference}"

          if params[preference] == "" && preference(key).present?
            unset_preference(key)
          end
        end
      end
    end
  end
end
