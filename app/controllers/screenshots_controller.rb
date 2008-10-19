class ScreenshotsController < ApplicationController
  before_filter :fetch_current_project
  before_filter :owner_required, :except => [:index, :show]
  
  def index
    @screenshots = current_project.screenshots.paginate(:per_page => 10, :page => params[:page])
  end

  def manage
    @screenshots = current_project.screenshots.paginate(:per_page => 10, :page => params[:page])
  end
  
  def show
    @screenshot = current_project.screenshots.find(params[:id])
  end
  
  def new
    @screenshot = current_project.screenshots.build
	render :layout => 'thickbox' if request.xhr?
  end
  
  def create
    @screenshot = current_project.screenshots.build(params[:screenshot])
    if @screenshot.save
      flash[:notice] = "Successfully created screenshot."
      record_activity @screenshot
      redirect_to project_screenshots_path(current_project)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @screenshot = current_project.screenshots.find(params[:id])
  end
  
  def update
    @screenshot = current_project.screenshots.find(params[:id])
    if @screenshot.update_attributes(params[:screenshot])
      flash[:notice] = "Successfully updated screenshot."
      record_activity @screenshot
      redirect_to [current_project, @screenshot]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @screenshot = current_project.screenshots.find(params[:id])
    @screenshot.destroy
    flash[:notice] = "Successfully destroyed screenshot."
      record_activity @screenshot
    redirect_to manage_project_screenshots_path(current_project)
  end
end
