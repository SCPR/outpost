require 'spec_helper'

describe Outpost::Controller::Authentication do
  describe "admin_user" do
    it "looks up the ID stored in the session" do
      user = create :user
      controller.session['_auth_user_id'] = user.id
      controller.current_user.should eq user
    end
    
    it "only finds user where can_login is true" do
      user = create :user, can_login: true
      controller.session['_auth_user_id'] = user.id
      controller.current_user.should eq user
      
      controller.instance_variable_set(:@current_user, nil)
      nologin_user = create :user, can_login: false
      controller.session['_auth_user_id'] = nologin_user.id
      controller.current_user.should eq nil
    end
    
    it "returns nil if session is blank" do
      controller.session['_auth_user_id'] = nil
      controller.current_user.should eq nil
    end
    
    it "unsets the session and returns false if the user isn't found" do
      controller.session['_auth_user_id'] = 999
      controller.current_user.should eq nil
      controller.session['_auth_user_id'].should eq nil
      controller.instance_variable_get(:@current_user).should eq nil
    end
  end
  
  #-----------------
  
  describe "require_login" do
    context "admin_user true" do
      it "returns nil" do
        user = create :user
        controller.stub(:current_user) { user }
        controller.require_login.should eq nil
      end
    end
    
    context "admin_user false" do
      controller do
        def index
          render nothing: true
        end
      end
      
      before :each do
        controller.stub(:current_user) { nil }
        controller.request.stub(:fullpath) { "/home" }
        get :index
      end
      
      it "sets the return_to to the request path" do
        controller.session[:return_to].should eq "/home"
      end
    
      it "redirects to login path if admin_user is false" do
        controller.response.should redirect_to outpost_login_path
      end
    end
  end
end
