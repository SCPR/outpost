require 'spec_helper'

describe Permission do
  describe "#title" do
    it "is the resource, titleized" do
      permission = Permission.new(resource: "SomeCoolThing")
      permission.title.should eq "Some Cool Thing"
    end
  end
end
