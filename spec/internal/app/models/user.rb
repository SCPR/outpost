class User < ActiveRecord::Base
  include Outpost::Model::Authentication
  include Outpost::Model::Authorization
end
