module Outpost
  class PeopleController < Outpost::ResourceController
    outpost_controller model: Person

    define_list do |l|
      l.default_order     = "name"
      l.default_sort_mode = "desc"
      l.per_page          = 25

      l.column :name
      l.column :email
      l.column :location
      l.column :age
    end

    self.permitted_params = [:name, :email, :location, :age]
  end
end
