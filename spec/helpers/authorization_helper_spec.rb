require 'spec_helper'

describe AuthorizationHelper do
  describe "#guard" do
    let(:current_user) { create :user, is_superuser: false }
    let(:permission) { create :permission, resource: "Post" }

    before :each do
      helper.stub(:current_user) { current_user }
    end
    
    it "returns the block if user has permission to manage the resource" do
      current_user.permissions.push permission
      helper.guard(Post) { "hello" }.should eq "hello"
    end
    
    it "returns nil if permission not granted and no message specified" do
      helper.guard(Post) { "hello" }.should eq ""
    end
    
    it "returns message if permission not granted and message specified" do
      helper.guard(Post, "Not Allowed") { "hello" }.should eq "Not Allowed"
    end
  end
  
  #-----------------
  
  describe "#guarded_link_to" do
    let(:current_user) { create :user, is_superuser: false }
    let(:permission) { create :permission, resource: "Post" }

    before :each do
      helper.stub(:current_user) { current_user }
    end
    
    it "sends to link_to if the user has permission" do
      current_user.permissions.push permission
      link = helper.guarded_link_to Post, "Title", "/some/path"
      link.should eq helper.link_to("Title", "/some/path")
    end
    
    it "shows only the title if permission is not granted" do
      link = helper.guarded_link_to Post, "Title", "/some/path"
      link.should eq "Title"
    end
  end  
end
