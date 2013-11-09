require 'spec_helper'

describe Outpost::List::Filter do
  let(:model) { Person }

  #----------------

  describe "initialization" do
    let(:list) { Outpost::List::Base.new(model) }

    before :each do
      list.filter "is_public", {
        :title      => "Public?",
        :collection => :boolean
      }
    end

    it "figures out title if none specified" do
      status_filter = list.filter "status"
      status_filter.title.should eq "status".titleize
    end

    describe "setting collection" do
      context "when collection is nil" do
        # Doesn't currently do anything
      end

      context "when collection is Proc" do
        it "sets the collection to the proc as-is" do
          id_proc   = -> { self.id }
          id_filter = list.filter "id", collection: id_proc
          id_filter.collection.should eq id_proc
        end
      end

      context "when collection is symbol" do
        it "uses the corresponding method" do
          is_visible_filter = list.filter "is_visible", collection: :boolean
          is_visible_filter.collection.call.should eq Outpost::List::Filter::BOOLEAN_COLLECT
        end
      end
    end
  end
end
