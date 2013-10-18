require 'spec_helper'

describe ListHelper do
  let(:list) { Outpost::List::Base.new(Person) }
  let(:person) { create :person, name: "Marty McFly", age: 17 }

  describe '#render_attribute' do
    it "evals the proc if the helper is a proc" do
      column = list.column(:name, display: ->(r) { "Mr. #{r.name}" })
      helper.render_attribute(column, person).should eq "Mr. Marty McFly"
    end

    it "uses _display_helper if it's present" do
      column = list.column(:name, display: :some_display)
      column._display_helper = :other_display
      helper.stub(:other_display) { "Cool Name Bro" }
      helper.render_attribute(column, person).should eq "Cool Name Bro"
    end

    it "sends the symbol if it's a symbol" do
      column = list.column(:name, display: :some_display)
      helper.stub(:some_display) { "Doc Brown" }
      helper.render_attribute(column, person).should eq "Doc Brown"
    end

    it "uses a generic attribute-based method if no display specified" do
      helper.class_eval do
        def display_name(name)
          "Mr. #{name}"
        end
      end

      column = list.column(:name)
      helper.render_attribute(column, person).should eq "Mr. Marty McFly"

      # Get rid of the method we just added, just to be safe
      helper.singleton_class.send :remove_method, :display_name
    end

    it "displays the association to_title if it is one" do
      list = Outpost::List::Base.new(Post)
      post = create :post, person: person
      column = list.column(:person)

      person.stub(:to_title) { "Biff" }
      helper.render_attribute(column, post).should eq "Biff"
    end

    it "tries an even more generic column type method" do
      helper.class_eval do
        def display_integer(int)
          int + 10
        end
      end

      column = list.column(:age)
      helper.render_attribute(column, person).should eq 27

      helper.singleton_class.send :remove_method, :display_integer
    end

    it "just renders the attribute as a string as a last resort" do
      column = list.column(:age)
      helper.render_attribute(column, person).should eq "17"
    end

    it "sets _display_helper on the column to help for the next columns" do
      column = list.column(:age)
      column._display_helper.should eq nil
      helper.render_attribute(column, person)
      column._display_helper.should eq :display_string
    end
  end

  describe '#direction_icon' do
    it 'returns icon-arrow-down when descending' do
      helper.direction_icon(Outpost::DESCENDING).should eq ListHelper::ICON_DOWN
    end

    it 'returns icon-arrow-up when ascending' do
      helper.direction_icon(Outpost::ASCENDING).should eq ListHelper::ICON_UP
    end
  end

  describe '#switch_direction' do
    let(:list) { Outpost::List::Base.new(User.new) }
    let(:column) { Outpost::List::Column.new("name", list,
          default_order_direction: Outpost::DESCENDING) }

    context 'attributes match' do
      it 'switches direction' do
        helper.switch_direction(
          column, "name", Outpost::DESCENDING).should eq Outpost::ASCENDING
      end

      it 'uses the default direction if no current direction' do
        helper.switch_direction(column, "name", nil).should eq Outpost::DESCENDING
      end
    end

    context 'attributes do not match' do
      it 'uses the column default order' do
        helper.switch_direction(
          column, "published", Outpost::DESCENDING).should eq Outpost::DESCENDING
      end
    end
  end
end
