require File.dirname(__FILE__) + '/../spec_helper'
 
describe CodeSnippetsController do
  fixtures :all
  integrate_views
  
  before(:each) do
    login
  end
  
  it "show action should render show template" do
    get :show, :id => CodeSnippet.first, :project_id => Project.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new, :project_id => Project.first
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    CodeSnippet.any_instance.stubs(:valid?).returns(false)
    post :create, :project_id => Project.first
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    CodeSnippet.any_instance.stubs(:valid?).returns(true)
    post :create, :project_id => Project.first
    response.should redirect_to(project_code_snippet_url(Project.first, assigns[:code_snippet]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => CodeSnippet.first, :project_id => Project.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    CodeSnippet.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CodeSnippet.first, :project_id => Project.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    CodeSnippet.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CodeSnippet.first, :project_id => Project.first
    response.should redirect_to(project_code_snippet_url(Project.first, assigns[:code_snippet]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    code_snippet = CodeSnippet.first
    delete :destroy, :id => code_snippet, :project_id => Project.first
    response.should redirect_to(project_url(Project.first))
    CodeSnippet.exists?(code_snippet.id).should be_false
  end
end
