require File.expand_path("../../../spec_helper", __FILE__)

describe Outpost::List::Base do
  
  #--------------
  
  let(:model) { Outpost::Test::Person }
  
  describe "initialize" do
    it "sets @columns to an empty array" do
      list = Outpost::List::Base.new(model)
      list.instance_variable_get(:@columns).should eq []
    end
    
    it "sets order to default" do
      list = Outpost::List::Base.new(model)
      list.default_order.should eq Outpost::List::DEFAULT_ORDER
    end

    it "sets sort_mode to default" do
      list = Outpost::List::Base.new(model)
      list.default_sort_mode.should eq Outpost::List::DEFAULT_SORT_MODE
    end

    it "sets per_page to default" do
      list = Outpost::List::Base.new(model)
      list.per_page.should eq Outpost::List::DEFAULT_PER_PAGE
    end
  end
  
  #--------------

  describe "column" do
    let(:list) { Outpost::List::Base.new(model) }

    before :each do
      column = Outpost::List::Column.new("name", list, {})
      Outpost::List::Column.should_receive(:new).with("name", list, {}).and_return(column)
    end
    
    it "creates a new column object" do
      list.column("name")
    end
    
    it "adds that column to the list" do
      column = list.column("name")
      list.columns.should eq [column]
    end
    
    it "returns the column" do
      column = list.column("name")
      column.should be_a Outpost::List::Column
    end
  end
  
  #--------------
  
  describe "per_page=" do
    let(:list) { Outpost::List::Base.new(model) }

    it "sets @per_page to nil if val is 'all'" do
      list.per_page = :all
      list.per_page.should be_nil
    end
    
    it "sets @per_page to passed-in value as an integer if specified" do
      list.per_page = "99"
      list.per_page.should eq 99
    end
  end
end
