require 'spec_helper'

describe 'save options' do
  before :each do
    login
    give_permission("Person")
    @person = create :person
    visit edit_outpost_person_path(@person)
  end

  context "Save" do
    it "returns to the edit page" do
      click_button "edit"
      current_path.should eq edit_outpost_person_path(@person)
      page.should have_css ".alert-success"
    end
  end

  context "Save & Return to List" do
    it "returns to the index page" do
      click_button "index"
      current_path.should eq outpost_people_path
      page.should have_css ".alert-success"
      page.should have_css ".index-header"
    end
  end

  context "Save & Add Another" do
    it "returns to the new page" do
      click_button "new"
      current_path.should eq new_outpost_person_path
      page.should have_css ".alert-success"
    end
  end
end
