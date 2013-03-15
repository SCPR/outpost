require 'spec_helper'

describe Outpost::Model::Authentication do
  describe "::authenticate" do 
    it "returns the user if the username and password are correct" do
      user = create :admin_user, unencrypted_password: "secret"
      AdminUser.authenticate(user.username, user.unencrypted_password).should eq user
    end
    
    it "returns false if the password is incorrect" do
      user = create :admin_user, unencrypted_password: "secret"
      AdminUser.authenticate(user.username, "wrong").should be_false
    end
    
    it "returns false if the username isn't found" do
      user = create :admin_user, username: "bricker"
      AdminUser.authenticate("wrong", "secret")
    end
  end

  #----------------
  
  describe "downcase_email" do
    it "downcases the e-mail before validating and saving a user" do
      user = create :admin_user, email: "SomeEmail@email.com"
      user.email.should eq "someemail@email.com"
    end
  end

  #----------------

  describe '#generate_username' do
    it "uses first initial + last name if it doesn't already exist" do
      user = build :user, name: "Jackie Brown"
      user.generate_username.should eq "jbrown"
    end

    it "increments the number until the username is available" do
      user1 = create :user, name: "Jackie Brown"
      user2 = create :user, name: "Jackson Brown"
      user3 = create :user, name: "James Brown"
      user4 = build :user, name: "Joe Brown"

      user1.username.should eq "jbrown"
      user2.username.should eq "jbrown1"
      user3.username.should eq "jbrown2"
      user4.generate_username.should eq "jbrown3"
    end

    it "strips out non-word characters" do
      user = build :user, name: "Leslie Berestein-Rojas"
      user.generate_username.should eq "lberesteinrojas"
    end

    it "Only uses first and last name for 3 names" do
      user = build :user, name: "Leslie Berestein Rojas"
      user.generate_username.should eq "lrojas"
    end
  end
end
