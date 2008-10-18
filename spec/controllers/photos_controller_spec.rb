require File.dirname(__FILE__) + '/../spec_helper'
 
describe PhotosController do
  fixtures :all
  integrate_views
  
  before(:each) do
    login
  end
  
  it "index action should render index template" do
    get :index, :project_id => Project.first
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Photo.first, :project_id => Project.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new, :project_id => Project.first
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Photo.any_instance.stubs(:valid?).returns(false)
    post :create, :project_id => Project.first
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Photo.any_instance.stubs(:valid?).returns(true)
    post :create, :project_id => Project.first
    response.should redirect_to(project_photo_url(Project.first, assigns[:photo]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Photo.first, :project_id => Project.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Photo.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Photo.first, :project_id => Project.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Photo.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Photo.first, :project_id => Project.first
    response.should redirect_to(project_photo_url(Project.first, assigns[:photo]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    photo = Photo.first
    delete :destroy, :id => photo, :project_id => Project.first
    response.should redirect_to(manage_project_photos_path(Project.first))
    Photo.exists?(photo.id).should be_false
  end
end
