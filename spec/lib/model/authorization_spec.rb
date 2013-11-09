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
    let(:permission1) { create :permission, resource: "Post" }
    let(:permission2) { create :permission, resource: "Pidgeon" }

    context 'superuser' do
      before :each do
        # eager load
        permission1
        permission2
      end

      let(:superuser) { create :user, is_superuser: true }

      it 'returns all Permissions' do
        superuser.allowed_resources.should eq [Post, Pidgeon]
      end
    end

    context 'user' do
      let(:user) { create :user, is_superuser: false }

      it "returns only that user's permissions" do
        user.permissions = [permission1]
        user.allowed_resources.should eq [Post]
      end

      it "ignores missing constants" do
        bad_permission = create :permission, resource: "NotAModel"
        user.permissions = [permission1, bad_permission]
        user.allowed_resources.should eq [Post]
      end
    end
  end
end
