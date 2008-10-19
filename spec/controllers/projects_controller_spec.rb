require File.dirname(__FILE__) + '/../spec_helper'

describe ProjectsController do
  fixtures :all
  integrate_views
  
  it_should_require_login_for_actions :index, :new, :edit, :update, :destroy
  
  it "show should render when using project token" do
    get :show, :id => Project.first.token
    response.should render_template(:show)
  end
end
 
describe ProjectsController, "logged in" do
  fixtures :all
  integrate_views
  
  before(:each) do
    login
  end
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Project.first
    response.should render_template(:show)
  end
  
  it "show action should redirect to root if user doesn't own project" do
    project = Factory(:project)
    get :show, :id => project
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Project.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Project.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(project_url(assigns[:project]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Project.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Project.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Project.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Project.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Project.first
    response.should redirect_to(project_url(assigns[:project]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    project = Project.first
    delete :destroy, :id => project
    response.should redirect_to(projects_url)
    Project.exists?(project.id).should be_false
  end
  
  it "update action should not allow setting project to different user" do
    user = Factory(:user)
    Project.any_instance.stubs(:valid?).returns(true)
    post :update, :id => Project.first, :project => { :user_id => user.id }
    response.should redirect_to(project_url(assigns[:project]))
    Project.first.user.should_not == user
  end
end
