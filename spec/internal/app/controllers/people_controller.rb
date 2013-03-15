class PeopleController < ApplicationController
  include Outpost::Controller::Authentication
  include Outpost::Controller::Authorization
  include Outpost::Breadcrumbs
  outpost_controller

  self.model = Person

  define_list do
    column :name
    column :email
    column :location
    column :age
  end
end
