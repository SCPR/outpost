require 'spec_helper'

describe Outpost::Model::Authentication do
  describe "::authenticate" do 
    it "returns the user if the username and password are correct" do
      user = create :user, password: "secret"
      User.authenticate(user.email, "secret").should eq user
    end
    
    it "returns false if the password is incorrect" do
      user = create :user, password: "secret"
      User.authenticate(user.email, "wrong").should eq false
    end
    
    it "returns false if the username isn't found" do
      user = create :user, email: "bricker@kpcc.org"
      User.authenticate("wrong", "secret").should eq false
    end
  end

  #----------------
  
  describe "downcase_email" do
    it "downcases the e-mail before validating and saving a user" do
      user = create :user, email: "SomeEmail@email.com"
      user.email.should eq "someemail@email.com"
    end
  end
end
