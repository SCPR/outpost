class Post < ActiveRecord::Base
  outpost_model
  belongs_to :person
end
