class Person < ActiveRecord::Base
  outpost_model public_route_key: "person"

  validates :name, presence: true
  validates :email, presence: true

  def route_hash
    {
      :id => self.id
    }
  end
end
