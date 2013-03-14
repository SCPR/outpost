module Outpost
  module Model
    module Authentication
      extend ActiveSupport::Concern

      included do
        has_secure_password
      end

      module ClassMethods
        def authenticate(username, unencrypted_password)
          self.find_by_username(username).try(:authenticate, unencrypted_password)
        end
      end
    end
  end
end
