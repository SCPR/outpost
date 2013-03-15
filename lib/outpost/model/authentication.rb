module Outpost
  module Model
    module Authentication
      extend ActiveSupport::Concern

      included do
        has_secure_password

        before_validation :downcase_email, if: -> { self.email_changed? }
        before_validation :generate_username, on: :create, if: -> { self.username.blank? }

        validates :name, presence: true
        validates :email, presence: true
        validates :username, presence: true, uniqueness: true
      end

      module ClassMethods
        def authenticate(username, unencrypted_password)
          self.find_by_username(username).try(:authenticate, unencrypted_password)
        end
      end

      private

      # Private: Generate a username based on real name
      #
      # Returns String of the username
      def generate_username
        names       = self.name.to_s.split
        base        = (names.first.chars.first + names.last).downcase.gsub(/\W/, "")
        dirty_name  = base

        i = 1
        while self.class.exists?(username: dirty_name)
          dirty_name = base + i.to_s
          i += 1
        end

        self.username = dirty_name
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
