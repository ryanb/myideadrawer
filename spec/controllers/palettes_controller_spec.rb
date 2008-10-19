require File.dirname(__FILE__) + '/../spec_helper'
 
describe PalettesController do
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
    get :show, :id => Palette.first, :project_id => Project.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new, :project_id => Project.first
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Palette.any_instance.stubs(:valid?).returns(false)
    post :create, :project_id => Project.first
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Palette.any_instance.stubs(:valid?).returns(true)
    post :create, :project_id => Project.first
    response.should redirect_to(project_palettes_url(Project.first))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Palette.first, :project_id => Project.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Palette.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Palette.first, :project_id => Project.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Palette.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Palette.first, :project_id => Project.first
    response.should redirect_to(project_url(Project.first))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    palette = Palette.first
    delete :destroy, :id => palette, :project_id => Project.first
    response.should redirect_to(project_palettes_url(Project.first))
    Palette.exists?(palette.id).should be_false
  end
end
