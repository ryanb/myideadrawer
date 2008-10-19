class PalettesController < ApplicationController
  before_filter :owner_required, :except => [:index, :show]
  
  def index
    @palettes = current_project.palettes.paginate(:per_page => 10, :page => params[:page])
  end
  
  def new
    @palette = current_project.palettes.build
  end
  
  def create
    @palette = current_project.palettes.build(params[:palette])
    if @palette.save
      flash[:notice] = "Successfully created palette."
      record_activity "Added #{@palette} palette to #{current_project} project."
      redirect_to current_project
    else
      render :action => 'new'
    end
  end
  
  def edit
    @palette = current_project.palettes.find(params[:id])
  end
  
  def update
    @palette = current_project.palettes.find(params[:id])
    if @palette.update_attributes(params[:palette])
      flash[:notice] = "Successfully updated palette."
      record_activity "Edited #{@palette} palette in #{current_project} project."
      redirect_to current_project
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @palette = current_project.palettes.find(params[:id])
    @palette.destroy
    flash[:notice] = "Successfully destroyed palette."
    record_activity "Removed #{@palette} palette from #{current_project} project."
    redirect_to current_project
  end
end
