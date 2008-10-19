class LinksController < ApplicationController
  before_filter :fetch_current_project
  before_filter :owner_required, :except => [:index, :show]
  
  def index
    @links = current_project.links.paginate(:per_page => 10, :page => params[:page])
  end
  
  def show
    @link = current_project.links.find(params[:id])
    redirect_to @link.url
  end
  
  def new
    @link = current_project.links.build
	render :layout => 'thickbox' if request.xhr?
  end
  
  def create
    @link = current_project.links.build(params[:link])
    if @link.save
      flash[:notice] = "Successfully created link."
      record_activity @link
      redirect_to current_project
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
      record_activity @link
      redirect_to project_url(current_project)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @link = current_project.links.find(params[:id])
    @link.destroy
    flash[:notice] = "Successfully destroyed link."
    record_activity @link
    redirect_to project_links_path(current_project)
  end
end
