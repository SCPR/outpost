module TestHelpers
  module AuthenticationHelper
    def login(options={})
      username = options[:username] || "bricker"
      email    = options[:email]    || "bricker1@kpcc.org"
      password = options[:password] || "secret55"

      @user = create :user,
        :username                 => username,
        :email                    => email,
        :password                 => password,
        :password_confirmation    => password

      visit outpost_login_path
      fill_in "email", with: @user.email
      fill_in "password", with: password
      click_button "Submit"
    end
  end
end
