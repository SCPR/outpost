require 'spec_helper'

describe 'destroying a record' do
  before :each do
    login
    give_permission("Person")

    @person = create :person
    visit edit_outpost_person_path(@person)
  end

  it "Deletes the record and redirects to index" do
    click_link "Delete"
    current_path.should eq outpost_people_path
    page.should have_css ".alert-success"
    Person.count.should eq 0
  end
end
