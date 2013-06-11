require 'spec_helper'

describe Outpost::Model::Routing do
  describe "::admin_new_path" do
    it "figures out the new path using singular_route_key" do
      Person.stub(:singular_route_key) { "employee" }
      Rails.application.routes.url_helpers.should_receive("new_outpost_employee_path")
      Person.admin_new_path
    end
  end
  
  describe '::admin_new_url' do
    it 'uses the apps routes' do
      Person.stub(:singular_route_key) { "employee" }
      Rails.application.routes.url_helpers.should_receive("new_outpost_employee_url")
      Person.admin_new_url
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

  describe '::admin_index_url' do
    it 'uses the apps routes' do
      Person.stub(:route_key) { "employees" }
      Rails.application.routes.url_helpers.should_receive("outpost_employees_url")
      Person.admin_index_url
    end
  end

  describe '::admin_create_path' do
    it 'is admin_index_path' do
      Person.admin_create_path.should eq Person.admin_index_path
    end
  end

  describe '::admin_create_url' do
    it 'is admin_index_url' do
      Person.admin_create_url.should eq Person.admin_index_url
    end
  end
  
  #---------------------
  
  context 'member routes' do
    let(:person) { create :person, name: "Thelonious Monk" }

    describe "#admin_edit_path" do
      it "figures out the edit path using singular_route_key and the record's id" do
        Person.stub(:singular_route_key) { "employee" }
        Rails.application.routes.url_helpers.should_receive("edit_outpost_employee_path").with(person.id)
        person.admin_edit_path
      end
    end

    describe "#admin_edit_url" do
      it "uses the apps routes" do
        Person.stub(:singular_route_key) { "employee" }
        Rails.application.routes.url_helpers.should_receive("edit_outpost_employee_url").with(person.id)
        person.admin_edit_url
      end
    end

    #---------------------
    
    describe "#admin_show_path" do
      it "figures out the show path using singular_route_key and the record's id" do
        Person.stub(:singular_route_key) { "employee" }
        Rails.application.routes.url_helpers.should_receive("outpost_employee_path").with(person.id)
        person.admin_show_path
      end
    end

    describe "#admin_show_url" do
      it "uses the apps routes" do
        Person.stub(:singular_route_key) { "employee" }
        Rails.application.routes.url_helpers.should_receive("outpost_employee_url").with(person.id)
        person.admin_show_url
      end
    end

    describe '#admin_update_path' do
      it 'is admin_show_path' do
        person.admin_update_path.should eq person.admin_show_path
      end
    end

    describe '#admin_update_url' do
      it 'is admin_show_url' do
        person.admin_update_url.should eq person.admin_show_url

      end
    end

    describe '#admin_destroy_path' do
      it 'is admin_show_path' do
        person.admin_destroy_path.should eq person.admin_show_path
      end
    end

    describe '#admin_destroy_path' do
      it 'is admin_show_url' do
        person.admin_destroy_url.should eq person.admin_show_url
      end
    end
    
    #----------------
    
    describe "#public_path" do
      it "returns nil if #route_hash is blank" do
        person.stub(:route_hash) { Hash.new }
        person.public_path.should eq nil
      end
      
      it "returns nil if if ROUTE_KEY isn't defined" do
        pidgeon = Pidgeon.new
        pidgeon.stub(:route_hash) { { id: 1, slug: "cool-dude" } }
        pidgeon.public_path.should eq nil
      end
      
      it "returns the route helper with the route hash" do
        Rails.application.routes.url_helpers.should_receive(:person_path).with(person.route_hash).and_return("/employee/999")
        person.public_path.should eq "/employee/999"
      end
    end
    
    #----------------
    
    describe "#route_hash" do
      it "is just an empty hash, meant to be overridden" do
        Pidgeon.new.route_hash.should eq Hash.new
      end
    end
    
    #----------------
    
    describe "#public_url" do
      before :each do
        person.stub(:public_path) { "/people/linkpath" }
        Rails.application.stub(:default_url_options).and_return(host: "www.omg.com")
      end
      
      it "contains the object's link path and configured remote URL" do
        person.public_url.should eq "http://www.omg.com/people/linkpath"
      end
    end
  end
end
