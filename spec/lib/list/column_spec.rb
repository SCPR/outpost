require File.expand_path("../../../spec_helper", __FILE__)

describe Outpost::List::Column do
  let(:model) { Outpost::Test::Person }

  #----------------
  
  describe "initialization" do
    let(:list) { Outpost::List::Base.new(model) }
    
    let(:column) {
      Outpost::List::Column.new("name", list, quick_edit: true, display: :display_full_name, header: "Full Name")
    }
    
    before :each do
      list.column "name"
    end
    
    it "sets attribute" do
      column.attribute.should eq "name"
    end
    
    it "sets position" do
      list.column "body"
      list.columns[0].position.should eq 0
      list.columns[1].position.should eq 1
    end
    
    it "sets header" do
      column.header.should eq "Full Name"
    end
    
    it "sets display" do
      column.display.should eq :display_full_name
    end
    
    it "sets quick_edit" do
      column.quick_edit.should eq true
    end
  end

  #----------------
  
  describe "#header" do
    let(:list) { Outpost::List::Base.new(model) }
    
    it "returns the header if passed in" do
      column = Outpost::List::Column.new("name", list, header: "Person")
      column.header = "Person"
    end
    
    it "returns the titleized attribute if no header specified" do
      column = Outpost::List::Column.new("name", list)
      column.header.should eq "Name"
    end
  end
  
  #----------------
  
  describe "#quick_edit?" do
    let(:list) { Outpost::List::Base.new(model) }
    
    it "is the same as #quick_edit" do
      column = Outpost::List::Column.new("name", list, quick_edit: true)
      column.quick_edit.should eq true
      column.quick_edit?.should eq true
    end
  end

  #----------------

  describe '#sortable?' do
    pending
  end

  #----------------

  describe '#default_sort_mode' do
    pending
  end
end
