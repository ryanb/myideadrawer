class LinksController < ApplicationController
  before_filter :owner_required, :except => :index
  
  def index
    @links = current_project.links.paginate(:per_page => 10, :page => params[:page])
  end
  
  def new
    @link = current_project.links.build
	render :layout => 'thickbox' if request.xhr?
  end
  
  def create
    @link = current_project.links.build(params[:link])
    if @link.save
      flash[:notice] = "Successfully created link."
      record_activity "Added #{@link} link to #{current_project} project."
      redirect_to project_url(current_project)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @link = current_project.links.find(params[:id])
  end
  
  def update
    @link = current_project.links.find(params[:id])
    if @link.update_attributes(params[:link])
      flash[:notice] = "Successfully updated link."
      record_activity "Edited #{@link} link in #{current_project} project."
      redirect_to project_url(current_project)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @link = current_project.links.find(params[:id])
    @link.destroy
    flash[:notice] = "Successfully destroyed link."
    record_activity "Removed #{@link} link from #{current_project} project."
    redirect_to project_url(current_project)
  end
end
