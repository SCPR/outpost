class Person < ActiveRecord::Base
  outpost_model
  ROUTE_KEY = "person"

  def route_hash
    {
      :id => self.id
    }
  end
end
