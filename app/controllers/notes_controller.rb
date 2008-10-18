class NotesController < ApplicationController
  before_filter :login_required
  
  def show
    @note = Note.find(params[:id])
  end
  
  def new
    @note = Note.new
  end
  
  def create
    @note = Note.new(params[:note])
    if @note.save
      flash[:notice] = "Successfully created note."
      record_activity "Added #{@note} note to #{@note.project} project", @note.project
      redirect_to @note
    else
      render :action => 'new'
    end
  end
  
  def edit
    @note = Note.find(params[:id])
  end
  
  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      flash[:notice] = "Successfully updated note."
      record_activity "Added #{@note} note to #{@note.project} project", @note.project
      redirect_to @note
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    flash[:notice] = "Successfully destroyed note."
    record_activity "Removed #{@note} note from #{@note.project} project.", @note.project
    redirect_to @note.project
  end
end
