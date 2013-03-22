require 'spec_helper'

describe Outpost::Model::Routing do
  describe "::admin_new_path" do
    it "figures out the new path using singular_route_key" do
      Person.stub(:singular_route_key) { "employee" }
      Rails.application.routes.url_helpers.should_receive("new_outpost_employee_path")
      Person.admin_new_path
    end
  end

  #---------------------
  
  describe "::admin_index_path" do
    it "figures out the index path using route_key" do
      Person.stub(:route_key) { "employees" }
      Rails.application.routes.url_helpers.should_receive("outpost_employees_path")
      Person.admin_index_path
    end
  end
  
  #---------------------
  
  describe "#admin_edit_path" do
    it "figures out the edit path using singular_route_key and the record's id" do
      Person.stub(:singular_route_key) { "employee" }
      person = create :person, name: "Thelonious Monk"
      Rails.application.routes.url_helpers.should_receive("edit_outpost_employee_path").with(person.id)
      person.admin_edit_path
    end
  end

  #---------------------
  
  describe "#admin_show_path" do
    it "figures out the show path using singular_route_key and the record's id" do
      Person.stub(:singular_route_key) { "employee" }
      person = create :person, name: "Charles Mingus"
      Rails.application.routes.url_helpers.should_receive("outpost_employee_path").with(person.id)
      person.admin_show_path
    end
  end
  
  #----------------
  
  describe "#link_path" do
    let(:person) { create :person, name: "Bob Loblaw" }
    
    it "returns nil if #route_hash is blank" do
      person.stub(:route_hash) { Hash.new }
      person.link_path.should eq nil
    end
    
    it "returns nil if if ROUTE_KEY isn't defined" do
      pidgeon = Pidgeon.new
      pidgeon.stub(:route_hash) { { id: 1, slug: "cool-dude" } }
      pidgeon.link_path.should eq nil
    end
    
    it "returns the route helper with the route hash" do
      Rails.application.routes.url_helpers.should_receive(:person_path).with(person.route_hash).and_return("/employee/999")
      person.link_path.should eq "/employee/999"
    end
  end
  
  #----------------
  
  describe "#route_hash" do
    it "is just an empty hash, meant to be overridden" do
      Pidgeon.new.route_hash.should eq Hash.new
    end
  end
  
  #----------------
  
  describe "#remote_link_path" do
    let(:person) { create :person, name: "Roy Haynes" }
    
    before :each do
      person.stub(:link_path) { "/people/linkpath" }
      Rails.application.stub(:default_url_options).and_return(host: "www.omg.com")
    end
    
    it "contains the object's link path and configured remote URL" do
      person.remote_link_path.should eq "http://www.omg.com/people/linkpath"
    end
  end
end
