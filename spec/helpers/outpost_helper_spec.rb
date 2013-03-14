require 'spec_helper'

describe OutpostHelper do
  describe "#any_to_list?" do
    it "returns the block if there are records" do
      helper.any_to_list?(1..5) { "Records list" }.should match "Records list"
    end
    
    it "returns a default message if there are no records and no message is specified" do
      helper.any_to_list?([]) { "Records list" }.should match "There is nothing here to list."
    end
    
    it "returns a specified message if there are no records" do
      helper.any_to_list?([], message: "None!") { "Records list" }.should match "None!"
    end
    
    it "returns a special message if: no records, no message, title is specified" do
      helper.any_to_list?([], title: "Events") { "Records list" }.should match "Events"
    end
  end

  # -----------------------
  
  describe "#format_date" do
    before :each do
      @date = Time.at(0).utc # 1970-01-01 00:00:00 UTC
    end
    
    it "returns a `iso` format" do
      helper.format_date(@date, format: :iso).should match "1970-01-01"
    end
    
    it "returns a `full-date` format" do
      helper.format_date(@date, format: :full_date).should match "January 1st, 1970"
    end
    
    it "returns a 'event' format" do
      helper.format_date(@date, format: :event).should match "Thursday, January 1"
    end
    
    it "accepts a custom format" do
      helper.format_date(@date, with: "%D").should match "01/01/70"
    end
    
    it "prefers the custom format if a premade format is also specified" do
      helper.format_date(@date, with: "%D", format: :event).should match "01/01/70"
    end
    
    it "includes the time if specified" do
      helper.format_date(@date, format: :event, time: true).should match "12:00am"
    end
  end
end
