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
      record_activity "Added #{@photo} photo to #{current_project} project."
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
      record_activity "Edited #{@photo} photo in #{current_project} project."
      redirect_to [current_project, @photo]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @photo = current_project.photos.find(params[:id])
    @photo.destroy
    flash[:notice] = "Successfully destroyed photo."
      record_activity "Removed #{@photo} photo from #{current_project} project."
    redirect_to current_project
  end
end
