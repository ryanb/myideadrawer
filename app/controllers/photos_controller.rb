class PhotosController < ApplicationController
  def index
    @photos = current_project.photos
  end
  
  def show
    @photo = current_project.photos.find(params[:id])
  end
  
  def new
    @photo = current_project.photos.build
  end
  
  def create
    @photo = current_project.photos.build(params[:photo])
    if @photo.save
      flash[:notice] = "Successfully created photo."
      redirect_to [current_project, @photo]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @photo = current_project.photos.find(params[:id])
  end
  
  def update
    @photo = current_project.photos.find(params[:id])
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Successfully updated photo."
      redirect_to [current_project, @photo]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @photo = current_project.photos.find(params[:id])
    @photo.destroy
    flash[:notice] = "Successfully destroyed photo."
    redirect_to current_project
  end
end
