require File.dirname(__FILE__) + '/../spec_helper'
 
describe UsersController do
  fixtures :all
  integrate_views
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "new should apply openid attributes to user model" do
    session[:openid_attributes] = { 'username' => 'foo', 'email' => 'bar', 'openid_url' => 'http://boo'}
    get :new
    response.should render_template(:new)
    assigns[:user].username.should == 'foo'
    assigns[:user].email.should == 'bar'
    assigns[:user].openid_url.should == 'http://boo'
    assigns[:user].errors.on(:email).should_not be_nil
    session[:openid_attributes].should be_nil
    
  end
  
  it "create action should render new template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(projects_url)
    assert_equal assigns['user'].id, session['user_id']
  end
  
  it_should_require_login_for_actions :edit, :update
end

describe UsersController, "logged in" do
  fixtures :all
  integrate_views
  
  before(:each) do
    login
  end
  
  it "edit action should render edit template" do
    get :edit, :id => :current
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => :current
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(true)
    put :update, :id => :current
    response.should redirect_to(projects_url)
  end
end
