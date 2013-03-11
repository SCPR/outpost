class PeopleController < ApplicationController
  outpost_controller
  include Outpost::Breadcrumbs

  self.model = Person

  define_list do
    column :name
    column :email
    column :location
    column :age
  end
end
