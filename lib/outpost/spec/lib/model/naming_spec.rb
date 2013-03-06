require File.expand_path("../../../spec_helper", __FILE__)

describe Outpost::Model::Naming do
  describe "::to_title" do
    it "returns the titleized class name" do
      Outpost::Test::Person.to_title.should eq "Person"
      Outpost::Test::Person.stub(:name) { "SomeModule::Person" }
      Outpost::Test::Person.to_title.should eq "Person"
      Outpost::Test::Person.stub(:name) { "SomeModule::PersonThing"}
      Outpost::Test::Person.to_title.should eq "Person Thing"
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
      person = Outpost::Test::Person.create(name: "Bryan Ricker")
      person.to_title.should eq "Bryan Ricker"
    end

    # This is actually being handled by config.title_attributes being injected
    # with :simple_title... we can test it here anyways
    it "falls back to a simple_title if none of the attributes match" do
      Outpost.config.title_attributes = [:title]
      person = Outpost::Test::Person.create(id: 1, name: "Bryan Ricker")
      person.should_receive(:simple_title).and_return("Simple Title")
      person.to_title.should eq "Simple Title"
    end
  end
  
  #----------------
  
  describe "#simple_title" do
    it "returns a simple name for a new object" do
      person = Outpost::Test::Person.new(id: 1, name: "Bryan Ricker")
      person.new_record?.should be_true
      person.simple_title.should eq "New Person"
    end
    
    it "returns a simple name for a persisted object" do
      person = Outpost::Test::Person.create(name: "Bryan Ricker")
      person.id.should be_present
      person.new_record?.should be_false
      person.simple_title.should eq "Person ##{person.id}"
    end
  end
end
