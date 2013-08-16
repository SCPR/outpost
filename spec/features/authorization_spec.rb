require 'spec_helper'

describe 'authorization' do
  context "without permission" do
    before :each do
      login
    end

    it 'redirects to the dashboard' do
      visit outpost_people_path
      current_path.should eq outpost_root_path
      page.should have_css ".alert-error"
      page.should have_content "You don't have permission"
    end
  end

  context 'with permission' do
    before :each do
      login
    end

    it 'goes to the page' do
      give_permission("Person")
      visit outpost_people_path
      current_path.should eq outpost_people_path
    end
  end
end
