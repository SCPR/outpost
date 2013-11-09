require 'spec_helper'

describe Outpost::List::Column do
  let(:model) { Person }

  #----------------

  describe "initialization" do
    let(:list) { Outpost::List::Base.new(model) }

    before :each do
      list.column "name", {
        :quick_edit   => true,
        :display      => :display_full_name,
        :header       => "Full Name"
      }
    end

    it "sets position" do
      list.column "body"
      list.columns["name"].position.should eq 0
      list.columns["body"].position.should eq 1
    end

    it "figures out header if none specified" do
      published_column = list.column :published_at
      published_column.header.should eq :published_at.to_s.titleize
    end

    it "sets quick_edit" do
      col = list.columns["name"]
      col.quick_edit.should eq true
      col.quick_edit?.should eq true
    end

    it "sets sortable" do
      col = list.columns["name"]
      col.sortable.should eq false
      col.sortable?.should eq false
    end

    it "sets default_order_direction to default if not specified" do
      list.columns["name"].default_order_direction.should eq Outpost::List::DEFAULT_ORDER_DIRECTION
    end
  end
end
