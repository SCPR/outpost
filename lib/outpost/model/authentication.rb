module Outpost
  module Model
    module Authentication
      extend ActiveSupport::Concern

      included do
        has_secure_password

        before_validation :downcase_email, if: -> { self.email_changed? }

        validates :name, presence: true
        validates :email, presence: true, uniqueness: true
      end

      module ClassMethods
        def authenticate(email, unencrypted_password)
          self.find_by_email(email).try(:authenticate, unencrypted_password)
        end
      end


      private

      def downcase_email
        if self.email.present?
          self.email = self.email.downcase
        end
      end
    end
  end
end
