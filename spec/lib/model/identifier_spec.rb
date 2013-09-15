require 'spec_helper'

describe Outpost::Model::Identifier do
  describe "::content_key" do
    it "tableizes the classname" do
      Person.content_key.should eq "person"
    end
  end

  describe '::new_obj_key' do
    it 'returns the new object key' do
      Person.new_obj_key.should eq 'person-new'
    end
  end

  #----------------

  describe "::route_key" do
    it "uses ActiveModel's route_key method" do
      ActiveModel::Naming.should_receive(:route_key)
      Person.route_key
    end
  end

  #----------------

  describe "::singular_route_key" do
    it "uses ActiveModel's singular_route_key method" do
      ActiveModel::Naming.should_receive(:singular_route_key)
      Person.singular_route_key
    end
  end

  #----------------

  describe "#obj_key" do
    context "for persisted record" do
      it "uses the class's content_key, the record's ID, and joins" do
        person = create :person
        person.id.should_not be_blank
        person.obj_key.should eq "person-#{person.id}"
      end
    end

    context "for new record" do
      it "uses new in the key" do
        person = build :person
        person.obj_key.should eq "person-new"
      end
    end
  end
end
