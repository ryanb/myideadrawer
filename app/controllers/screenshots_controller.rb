class ScreenshotsController < ApplicationController
  def index
    @screenshots = current_project.screenshots.find(:all)
  end
  
  def show
    @screenshot = current_project.screenshots.find(params[:id])
  end
  
  def new
    @screenshot = current_project.screenshots.build
  end
  
  def create
    @screenshot = current_project.screenshots.build(params[:screenshot])
    if @screenshot.save
      flash[:notice] = "Successfully created screenshot."
      redirect_to [current_project, @screenshot]
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
      redirect_to [current_project, @screenshot]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @screenshot = current_project.screenshots.find(params[:id])
    @screenshot.destroy
    flash[:notice] = "Successfully destroyed screenshot."
    redirect_to current_project
  end
end
