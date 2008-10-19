class ProjectsController < ApplicationController
  before_filter :login_required, :only => :index
  before_filter :owner_required, :except => [:index, :show]
  
  def index
    @projects = current_user.projects.paginate(:per_page => 10, :page => params[:page])
  end
  
  def show
    @project = current_project # so it can be fetched by token
  end
  
  def new
    @project = current_user.projects.build
  end
  
  def create
    @project = current_user.projects.build(params[:project])
	@project.last_activity_at = Time.now
    if @project.save
      flash[:notice] = "Successfully created project."
      record_activity "Created #{@project} project."
      redirect_to @project
    else
      render :action => 'new'
    end
  end
  
  def edit
    @project = current_user.projects.find(params[:id])
  end
  
  def update
    @project = current_user.projects.find(params[:id])
    @project.last_activity_at = Time.now
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      record_activity "Edited #{@project} project details."
      redirect_to @project
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    record_activity "Destroyed #{@project} project."
    redirect_to projects_url
  end
end