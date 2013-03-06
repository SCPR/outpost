require Rails.root.join 'lib/outpost/spec/test_classes/person'

module Outpost
  module Test
    class PeopleController < ActionController::Base
      outpost_controller
      include Outpost::Breadcrumbs
  
      self.model = Outpost::Test::Person

      define_list do
        column :name
        column :email
        column :location
        column :age
      end
      
      def params
        {
          controller: "admin/people"
        }
      end
    end # PeopleController
  end # Test
end # Outpost
