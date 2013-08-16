require 'spec_helper'

describe "creating a new record" do
  before :each do
    login
    give_permission("Person")
    visit new_outpost_person_path
  end

  context "invalid" do
    it "shows validation errors" do
      fill_in "person_name", with: ""
      fill_in "person_email", with: ""
      click_button "edit"
      current_path.should eq outpost_people_path

      Person.count.should eq 0

      page.should_not have_css ".alert-success"

      # FIXME: These are too specific to simple form
      page.should have_content "Please review the problems below"
      page.should have_css ".error"
    end
  end

  context "valid" do
    it "is created" do
      fill_in "person_name", with: "Bryan"
      fill_in "person_email", with: "bricker@kpcc.org"
      click_button "edit"

      person = Person.first
      current_path.should eq edit_outpost_person_path(person)

      Person.count.should eq 1

      page.should have_css ".alert-success"
      page.should_not have_content "Please review the problems below"
      page.should_not have_css ".error"
      page.should have_css "#edit_#{Person.singular_route_key}_#{person.id}"
    end
  end
end
