require "spec_helper"

describe Outpost::SessionsController do
  # -------------------------
  
  describe "GET /new" do
    it "returns success and renders new template if current_user false" do
      controller.stub(:current_user) { false }
      get :new
      response.should be_success
      response.should render_template "new"
    end
    
    it "redirects to home page if current_user if true" do
      controller.stub(:current_user) { true }
      get :new
      response.should redirect_to outpost_root_path
    end
  end
  
  # -------------------------
  
  describe "POST /create" do
    describe "authentication fails" do
      before :each do
        post :create # no params, login info is nil, authentication will fail
      end
      
      it "renders the login form" do
        controller.response.should render_template 'new'
      end
    
      it "sets the flash.now" do
        controller.flash.now[:alert].should be_present
      end
    end
    
    describe "authentication passes" do
      let(:user) { create :user }

      before :each do
        post :create, unencrypted_password: "secret", username: user.username
      end
      
      it "sets the session" do
        controller.should set_session("_auth_user_id").to(user.id)
      end
  
      it "redirects to admin root" do
        controller.response.should redirect_to outpost_root_path
      end
      
      it "sets the flash" do
        controller.flash[:notice].should be_present
      end
    end
  end
  
  # -------------------------
  
  describe "DELETE /destroy" do
    let(:user) { create :user }

    it "unsets @current_user" do 
      controller.instance_variable_set(:@current_user, user)
      get :destroy
      controller.instance_variable_get(:@current_user).should be_nil
    end
    
    it "unsets session" do
      controller.session['_auth_user_id'] = user.id
      get :destroy
      controller.session['_auth_user_id'].should be_nil
    end
    
    it "redirects to login page" do
      get :destroy
      controller.response.should redirect_to outpost_login_path
    end
    
    it "sets the flash" do
      get :destroy
      controller.flash[:notice].should be_present
    end
  end
  
  # -------------------------
  
end
