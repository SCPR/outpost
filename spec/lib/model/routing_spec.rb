require File.expand_path("../../../spec_helper", __FILE__)

describe Outpost::Model::Routing do
  describe "::admin_new_path" do
    it "figures out the new path using singular_route_key" do
      Outpost::Test::Person.stub(:singular_route_key) { "coolguy" }
      Rails.application.routes.url_helpers.should_receive("new_outpost_coolguy_path")
     Outpost::Test::Person.admin_new_path
    end
  end

  #---------------------
  
  describe "::admin_index_path" do
    it "figures out the index path using route_key" do
      Outpost::Test::Person.stub(:route_key) { "coolguys" }
      Rails.application.routes.url_helpers.should_receive("outpost_coolguys_path")
      Outpost::Test::Person.admin_index_path
    end
  end
  
  #---------------------
  
  describe "#admin_edit_path" do
    it "figures out the edit path using singular_route_key and the record's id" do
      Outpost::Test::Person.stub(:singular_route_key) { "coolguy" }
      person = Outpost::Test::Person.new(name: "Cool Guy")
      Rails.application.routes.url_helpers.should_receive("edit_outpost_coolguy_path").with(person.id)
      person.admin_edit_path
    end
  end

  #---------------------
  
  describe "#admin_show_path" do
    it "figures out the show path using singular_route_key and the record's id" do
      Outpost::Test::Person.stub(:singular_route_key) { "coolguy" }
      person = Outpost::Test::Person.new(name: "Cool Guy")
      Rails.application.routes.url_helpers.should_receive("outpost_coolguy_path").with(person.id)
      person.admin_show_path
    end
  end
  
  #----------------
  
  describe "#link_path" do
    let(:person) { Outpost::Test::Person.new(name: "Bob Loblaw") }
    
    it "returns nil if #route_hash is blank" do
      person.stub(:route_hash) { Hash.new }
      person.link_path.should eq nil
    end
    
    it "returns nil if if ROUTE_KEY isn't defined" do
      pidgeon = Outpost::Test::Pidgeon.new
      pidgeon.stub(:route_hash) { { id: 1, slug: "cool-dude" } }
      pidgeon.link_path.should eq nil
    end
    
    it "returns the route helper with the route hash" do
      Rails.application.routes.url_helpers.should_receive(:people_path).with(person.route_hash).and_return("blahblahblah")
      person.link_path.should eq "blahblahblah"      
    end
  end
  
  #----------------
  
  describe "#route_hash" do
    it "is just an empty hash, meant to be overridden" do
      Outpost::Test::Pidgeon.new.route_hash.should eq Hash.new
    end
  end
  
  #----------------
  
  describe "#remote_link_path" do
    let(:person) { Outpost::Test::Person.create(name: "Dude Bro") }
    
    before :each do
      person.stub(:link_path) { "/people/linkpath" }
      Rails.application.config.scpr.stub(:host) { "www.foodnstuff.com" }
    end
    
    it "contains the object's link path and configured remote URL" do
      person.remote_link_path.should eq "http://www.foodnstuff.com/people/linkpath"
    end
  end
end
