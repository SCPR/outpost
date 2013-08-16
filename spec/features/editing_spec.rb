require 'spec_helper'

describe "creating a new record" do
  before :each do
    login
    give_permission("Person")

    @person = create :person
    visit edit_outpost_person_path(@person)
  end

  context "invalid" do
    it "shows validation errors" do
      fill_in "person_name", with: ""
      fill_in "person_email", with: ""
      click_button "edit"

      current_path.should eq outpost_person_path(@person)

      page.should_not have_css ".alert-success"

      # FIXME: These are too specific to simple form
      page.should have_content "Please review the problems below"
      page.should have_css ".error"
    end
  end

  context "valid" do
    it "is saved" do
      fill_in "person_name", with: "New Name"
      click_button "edit"

      @person.reload
      current_path.should eq edit_outpost_person_path(@person)

      page.should have_css ".alert-success"
      page.should_not have_content "Please review the problems below"
      page.should_not have_css ".error"

      @person.name.should eq "New Name"
    end
  end
end
