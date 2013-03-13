require 'spec_helper'

describe AuthorizationHelper do
  describe "#guard" do
    let(:admin_user) { create :admin_user, is_superuser: false }
    let(:permission) { Permission.find_by_resource("NewsStory") }

    before :each do
      helper.stub(:admin_user) { admin_user }
    end
    
    it "returns the block if admin user has permission to manage the resource" do
      admin_user.permissions.push permission
      helper.guard(NewsStory) { "hello" }.should eq "hello"
    end
    
    it "returns nil if permission not granted and no message specified" do
      helper.guard(NewsStory) { "hello" }.should eq nil
    end
    
    it "returns message if permission not granted and message specified" do
      helper.guard(NewsStory, "Not Allowed") { "hello" }.should eq "Not Allowed"
    end
  end
  
  #-----------------
  
  describe "#guarded_link_to" do
    let(:admin_user) { create :admin_user, is_superuser: false }
    let(:permission) { Permission.find_by_resource("NewsStory") }

    before :each do
      helper.stub(:admin_user) { admin_user }
    end
    
    it "sends to link_to if the user has permission" do
      admin_user.permissions.push permission
      link = helper.guarded_link_to NewsStory, "Title", "/some/path"
      link.should eq helper.link_to("Title", "/some/path")
    end
    
    it "shows only the title if permission is not granted" do
      link = helper.guarded_link_to NewsStory, "Title", "/some/path"
      link.should eq "Title"
    end
  end  
end
