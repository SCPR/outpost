class Person < ActiveRecord::Base
  outpost_model
  ROUTE_KEY = "person"

  validates :name, presence: true
  validates :email, presence: true

  def route_hash
    {
      :id => self.id
    }
  end
end
