class ProjectsController < ApplicationController
  before_filter :login_required
  
  def index
    @projects = current_user.projects
  end
  
  def show
    @project = current_user.projects.find(params[:id])
  end
  
  def new
    @project = current_user.projects.build
  end
  
  def create
    @project = current_user.projects.build(params[:project])
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
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      record_activity "Updated #{@project} project details."
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
