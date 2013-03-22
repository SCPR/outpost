require 'spec_helper'

describe Outpost::List::Base do

  #--------------
  
  let(:model) { Person }
  
  describe "initialize" do
    context "with block" do
      it "yields and sets attributes" do
        list = Outpost::List::Base.new model do |l|
          l.default_order     = "omg"
          l.default_sort_mode = "wtf"
          l.per_page          = 999
        end

        list.default_order.should     eq "omg"
        list.default_sort_mode.should eq "wtf"
        list.per_page.should          eq 999
      end

      it "sets any attributes that weren't set in the block" do
        list = Outpost::List::Base.new model do |l|
          l.default_order     = "omg"
        end

        list.default_order.should     eq "omg"
        list.default_sort_mode.should eq Outpost::List::DEFAULT_SORT_MODE
        list.per_page.should          eq Outpost::List::DEFAULT_PER_PAGE
      end
    end

    context "without block" do
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
  end
  
  #--------------

  describe "column" do
    let(:list) { Outpost::List::Base.new(model) }

    it "creates a new column object and adds it to the columns" do
      column = list.column("name")
      column.should be_a Outpost::List::Column
      list.columns.should eq Hash["name" => column]
    end

    it "sets the column's list to self" do
      column = list.column("name")
      column.list.should eq list
    end
  end

  #--------------

  describe "filter" do
    let(:list) { Outpost::List::Base.new(model) }

    it "creates a new filter object and adds it to the filters" do
      filter = list.filter("name")
      filter.should be_a Outpost::List::Filter
      list.filters.should eq Hash["name" => filter]
    end

    it "sets the filters's list to self" do
      filter = list.filter("name")
      filter.list.should eq list
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
