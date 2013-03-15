class UserPermission < ActiveRecord::Base
  belongs_to :user, class_name: Outpost.user_class
  belongs_to :permission
end
