class Permission < ActiveRecord::Base
  outpost_model
  
  #-------------------
  # Association
  has_many :user_permissions
  has_many :users, class_name: Outpost.user_class, through: :user_permissions, dependent: :destroy
  
  #-------------------
  # Validation
  validates :resource, uniqueness: true
  
  #-------------------
  
  def title
    self.resource.titleize
  end
end
