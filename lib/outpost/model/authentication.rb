module Outpost
  module Model
    module Authentication
      extend ActiveSupport::Concern

      included do
        has_secure_password

        before_validation :downcase_email

        validates :name, presence: true
        validates :email, presence: true, uniqueness: true
      end

      module ClassMethods
        def authenticate(email, unencrypted_password)
          self.find_by_email(email).try(:authenticate, unencrypted_password)
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
