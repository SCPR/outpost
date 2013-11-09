require 'spec_helper'

describe Outpost::Hook do
  before :each do
    @hook = Outpost::Hook.new(path: "finished")
  end

  describe "#publish" do
    it "posts to the uri with the data" do
      pending
    end
  end
end
