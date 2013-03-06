require File.expand_path("../../../spec_helper", __FILE__)

describe Outpost::Controller::Helpers do
  let(:controller) { Outpost::Test::PeopleController.new }

  describe "#model" do
    it "adds model as a helper" do
      controller._helper_methods.should include :model
    end
  end
  
  #------------------------
  
  describe "#notice" do
    context "HTML request" do
      it "adds the notice to flash" do
        pending
      end
    end
    
    context "non-HTML request" do
      it "doesn't add anything to flash" do
        pending
      end
    end
  end

  #------------------------
  
  describe '#preference' do
    pending
  end
end
