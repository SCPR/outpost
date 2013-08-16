module TestHelpers
  module AuthenticationHelper
    def give_permission(*resources)
      if !@user
        raise "User must be set to build permissions"
      end

      resources.each do |resource|
        @user.permissions << create(:permission, resource: resource)
      end
    end
  end
end
