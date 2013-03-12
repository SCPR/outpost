require File.expand_path("../../spec_helper", __FILE__)

describe Outpost::Controller do
  let(:controller) { Outpost::Test::PeopleController.new }

  describe '::fields' do
    it 'sets default fields' do
      controller.fields.should include "name"
      controller.fields.should include "email"
      controller.fields.should_not include "id"
      controller.fields.should_not include "updated_at"
      controller.fields.should_not include "created_at"
    end
  end
end
