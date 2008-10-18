require File.dirname(__FILE__) + '/../spec_helper'
 
describe NotesController do
  fixtures :all
  integrate_views
  
  it "show action should render show template" do
    get :show, :id => Note.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Note.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Note.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(note_url(assigns[:note]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Note.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Note.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Note.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Note.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Note.first
    response.should redirect_to(note_url(assigns[:note]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    note = Note.first
    delete :destroy, :id => note
    response.should redirect_to(project_url(note.project))
    Note.exists?(note.id).should be_false
  end
end
