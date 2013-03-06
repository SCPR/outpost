module Outpost
  module Test
    class Person < ActiveRecord::Base
      outpost_model

      attr_accessible :name, :email, :location, :age
      ROUTE_KEY = "people"

      def route_hash
        {
          :id   => self.id,
          :slug => self.name.parameterize
        }
      end
    end # Person
  end # Test
end # Model
