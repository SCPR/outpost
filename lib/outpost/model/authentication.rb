module Outpost
  module Model
    module Authentication
      extend ActiveSupport::Concern

      included do
        has_secure_password

        before_validation :downcase_email, if: -> { self.email_changed? }

        validates :name, presence: true
        validates Outpost.config.authentication_attribute,
          :presence     => true,
          :uniqueness   => true
      end

      module ClassMethods
        def authenticate(login, unencrypted_password)
          if user = self.send(
          "find_by_#{Outpost.config.authentication_attribute}", login)
            user.authenticate(unencrypted_password)
          else
            false
          end
        end
      end

      # Private: Downcase the user's e-mail
      #
      # Returns String of the e-mail
      def downcase_email
        if self.email.present?
          self.email = self.email.downcase
        end
      end
    end
  end
end
