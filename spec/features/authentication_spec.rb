require 'spec_helper'

describe 'authentication' do
  context 'not logged in' do
    it 'redirects to login path' do
      visit outpost_people_path
      current_path.should eq outpost.login_path
    end
  end

  describe "logging in" do
    before :each do
      @user = create :user,
        :email                    => "bricker@kpcc.org",
        :password                 => "secret",
        :password_confirmation    => "secret"

      visit outpost.login_path
    end

    context 'incorrect login information' do
      it 'redirects back to login form' do
        fill_in "email", with: "nope@nope.nope"
        fill_in "password", with: "secret"
        click_button "Submit"

        current_path.should eq outpost.sessions_path
        page.should have_css ".alert-error"
      end
    end

    context "correct login information" do
      it 'logs the user in and redirects to dashboard' do
        fill_in "email", with: @user.email
        fill_in "password", with: "secret"
        click_button "Submit"

        current_path.should eq outpost.root_path
        page.should have_css ".alert-success"
      end
    end
  end
end
