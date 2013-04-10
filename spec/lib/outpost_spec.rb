require 'spec_helper'

describe Outpost do
  describe "::obj_by_key" do
    context "no match" do
      it "returns nil" do
        Outpost.obj_by_key("nomatch").should eq nil
      end
      
      it "accepts nil argument" do
        Outpost.obj_by_key(nil).should eq nil
      end
    end
    
    context "match" do
      it "is nil if no record exists" do
        Outpost.obj_by_key("blogs/entry:9999999").should eq nil
      end
    
      it "finds and returns the record if everything matches" do
        post = create :post
        puts Post.find(post.id)
        Outpost.obj_by_key(post.obj_key).should eq post
      end
    end
  end

  #---------------
  
  describe "::obj_by_key!" do
    it "raises an error if no object is found" do
      -> { Outpost.obj_by_key!("something") }.should raise_error ActiveRecord::RecordNotFound
    end
  end
end
