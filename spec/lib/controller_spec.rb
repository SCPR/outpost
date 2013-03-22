require 'spec_helper'

describe Outpost::Controller do
  describe '::fields' do
    let(:controller) { Outpost::PeopleController.new }

    it 'sets default fields' do
      controller.fields.should include "name"
      controller.fields.should include "email"
      controller.fields.should_not include "id"
      controller.fields.should_not include "updated_at"
      controller.fields.should_not include "created_at"
    end
  end

  describe "::list" do
    let(:controller) { PidgeonsController.new }

    it "defines a list if it hasn't been already" do
      PidgeonsController.instance_variable_get(:@list).should eq nil
      list = PidgeonsController.list
      list.should be_a Outpost::List::Base
    end
  end
end
