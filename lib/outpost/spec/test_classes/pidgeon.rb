module Outpost
  module Test
    class Pidgeon < ActiveRecord::Base
      include Outpost::Model::Routing
    end
  end
end
