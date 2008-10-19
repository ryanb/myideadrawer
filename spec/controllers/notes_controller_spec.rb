require File.dirname(__FILE__) + '/../spec_helper'

describe NotesController, "logged in" do
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
    get :show, :id => Note.first, :project_id => Project.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new, :project_id => Project.first
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Note.any_instance.stubs(:valid?).returns(false)
    post :create, :project_id => Project.first
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Note.any_instance.stubs(:valid?).returns(true)
    post :create, :project_id => Project.first
    response.should redirect_to(project_note_url(assigns[:project], assigns[:note]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Note.first, :project_id => Project.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Note.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Note.first, :project_id => Project.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Note.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Note.first, :project_id => Project.first
    response.should redirect_to(project_note_url(assigns[:project], assigns[:note]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    note = Note.first
    delete :destroy, :id => note, :project_id => Project.first
    response.should redirect_to(project_notes_url(note.project))
    Note.exists?(note.id).should be_false
  end
end
