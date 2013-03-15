require 'spec_helper'

describe Outpost::Model::Authorization do
  describe "#can_manage?" do
    let(:permission1) { create :permission, resource: "Post" }
    let(:permission2) { create :permission, resource: "Pidgeon" }

    context "superuser" do
      let(:superuser) { create :user, is_superuser: true }
      
      it "is true for superusers" do
        superuser.can_manage?("anything").should eq true
      end
    end
    
    context "non-superuser" do
      let(:user) { create :user, is_superuser: false }
      
      it "is true if the user can manage all of the passed-in resources" do
        user.permissions += [permission1, permission2]
        user.can_manage?(Post, Pidgeon).should eq true
      end
    
      it "is false if the user can manage only some of the passed-in resources" do
        user.permissions += [permission1]
        user.can_manage?(Post, Pidgeon).should eq false
      end
    end
  end

  #--------------------

  describe '#allowed_resource' do
    pending
  end
end
