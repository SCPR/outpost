require File.expand_path("../../spec_helper", __FILE__)

describe Outpost::Config do
  describe "::configure" do
    it "generates a new Config object" do
      Outpost::Config.should_receive(:new)
      Outpost::Config.configure
    end
    
    it "accepts a block with the config object" do
      Outpost::Config.configure do |config|
        config.should be_a Outpost::Config
      end
    end
    
    it "sets Outpost.config to the new Config object" do
      Outpost::Config.configure
      Outpost.config.should be_a Outpost::Config
    end
  end
  
  #----------------------

  describe "#registered_models" do
    it "returns an empty array if nothing is set" do
      Outpost.config.registered_models = nil
      Outpost.config.registered_models.should eq []
    end
  end

  #----------------------
  
  describe "#title_attributes" do
    it "returns the defaults plus :simple_title if nothing is set" do
      stub_const("Outpost::Config::DEFAULTS", { title_attributes: [:title] })
      Outpost.config.title_attributes = nil
      Outpost.config.title_attributes.should eq [:title, :simple_title]
    end
    
    it "always includes simple_title" do
      stub_const("Outpost::Config::DEFAULTS", { title_attributes: [] })
      Outpost.config.title_attributes = nil
      Outpost.config.title_attributes.should eq [:simple_title]
    end
  end
  
  #----------------------
  
  describe "#excluded_form_fields" do
    it "returns the defaults if nothing is set" do
      stub_const("Outpost::Config::DEFAULTS", { excluded_form_fields: [:title] })
      Outpost.config.excluded_form_fields = nil
      Outpost.config.excluded_form_fields.should eq [:title]
    end
    
    it "always included the defaults" do
      stub_const("Outpost::Config::DEFAULTS", { excluded_form_fields: [:title] })
      Outpost.config.excluded_form_fields = [:body, :title]
      Outpost.config.excluded_form_fields.should eq [:body, :title]
    end
  end
  
  #----------------------
  
  describe "#excluded_list_columns" do
    it "returns the defaults if nothing is set" do
      stub_const("Outpost::Config::DEFAULTS", { excluded_list_columns: ["title"] })
      Outpost.config.excluded_list_columns = nil
      Outpost.config.excluded_list_columns.should eq ["title"]
    end
    
    it "always included the defaults" do
      stub_const("Outpost::Config::DEFAULTS", { excluded_list_columns: ["title"] })
      Outpost.config.excluded_list_columns = ["body", "title"]
      Outpost.config.excluded_list_columns.should eq ["body", "title"]
    end
  end
end
