module Outpost
  module Model
    module Authorization
      extend ActiveSupport::Concern

      included do
        has_many :user_permissions
        has_many :permissions, through: :user_permissions
      end

      # Check if a user can manage the passed-in resource(s)
      #
      # If multiple resources are passed in, a user must be
      # allowed to manage ALL of them in order for this to
      # return true.
      #
      # Constants must be passed in.
      #
      def can_manage?(*resources)
        self.is_superuser? or (allowed_resources & resources) == resources
      end

      def allowed_resources
        @allowed_resources ||= begin
          p = self.is_superuser? ? Permission.all : self.permissions
          p.map { |p| p.resource.safe_constantize }.compact
        end
      end
    end
  end
end
