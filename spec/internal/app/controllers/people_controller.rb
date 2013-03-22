class PeopleController < ApplicationController
  include Outpost::Controller::Authentication
  include Outpost::Controller::Authorization
  include Outpost::Breadcrumbs

  outpost_controller model: Person

  define_list do |l|
    l.default_order     = "published_at"
    l.default_sort_mode = "desc"
    l.per_page          = 25

    l.column :name
    l.column :email
    l.column :location
    l.column :age
  end
end
