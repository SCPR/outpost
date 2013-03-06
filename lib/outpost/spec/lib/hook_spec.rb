require File.expand_path("../../spec_helper", __FILE__)

describe Outpost::Hook do
  before :each do
    @hook = Outpost::Hook.new(path: "finished")
  end
  
  describe "#publish" do
    it "posts to the uri with the data" do
      FakeWeb.register_uri(:post, %r|#{Rails.application.config.node.server}|, status: ["200", "OK"])
      @hook.publish
    end
  end
end
