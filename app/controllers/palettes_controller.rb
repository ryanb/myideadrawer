class PalettesController < ApplicationController
  def index
    @palettes = current_project.palettes.find(:all)
  end
  
  def new
    @palette = current_project.palettes.build
  end
  
  def create
    @palette = current_project.palettes.build(params[:palette])
    if @palette.save
      flash[:notice] = "Successfully created palette."
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
      redirect_to current_project
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @palette = current_project.palettes.find(params[:id])
    @palette.destroy
    flash[:notice] = "Successfully destroyed palette."
    redirect_to current_project
  end
end
