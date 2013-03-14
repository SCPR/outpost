require 'spec_helper'

describe Outpost::Model::Naming do
  describe "::to_title" do
    it "returns the titleized class name" do
      Person.to_title.should eq "Person"
      Person.stub(:name) { "SomeModule::Person" }
      Person.to_title.should eq "Person"
      Person.stub(:name) { "SomeModule::PersonThing"}
      Person.to_title.should eq "Person Thing"
    end
  end

  #----------------
  
  describe "#title_method" do
    pending
  end
  
  #----------------
  
  describe "#to_title" do
    it "uses one of the specified title attributes if available" do
      Outpost.config.title_attributes = [:name]
      person = Person.create(name: "Bryan Ricker")
      person.to_title.should eq "Bryan Ricker"
    end

    # This is actually being handled by config.title_attributes being injected
    # with :simple_title... we can test it here anyways
    it "falls back to a simple_title if none of the attributes match" do
      Outpost.config.title_attributes = [:title]
      person = Person.create(id: 1, name: "Bryan Ricker")
      person.should_receive(:simple_title).and_return("Simple Title")
      person.to_title.should eq "Simple Title"
    end
  end
  
  #----------------
  
  describe "#simple_title" do
    it "returns a simple name for a new object" do
      person = Person.new(id: 1, name: "Bryan Ricker")
      person.new_record?.should be_true
      person.simple_title.should eq "New Person"
    end
    
    it "returns a simple name for a persisted object" do
      person = Person.create(name: "Bryan Ricker")
      person.id.should be_present
      person.new_record?.should be_false
      person.simple_title.should eq "Person ##{person.id}"
    end
  end
end
