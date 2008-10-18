class CodeSnippetsController < ApplicationController
  def show
    @code_snippet = current_project.code_snippets.find(params[:id])
  end
  
  def new
    @code_snippet = current_project.code_snippets.build
  end
  
  def create
    @code_snippet = current_project.code_snippets.build(params[:code_snippet])
    if @code_snippet.save
      flash[:notice] = "Successfully created code snippet."
      redirect_to [current_project, @code_snippet]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @code_snippet = current_project.code_snippets.find(params[:id])
  end
  
  def update
    @code_snippet = current_project.code_snippets.find(params[:id])
    if @code_snippet.update_attributes(params[:code_snippet])
      flash[:notice] = "Successfully updated code snippet."
      redirect_to [current_project, @code_snippet]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @code_snippet = current_project.code_snippets.find(params[:id])
    @code_snippet.destroy
    flash[:notice] = "Successfully destroyed code snippet."
    redirect_to current_project
  end
end
