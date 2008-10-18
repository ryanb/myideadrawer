class UsersController < ApplicationController
  before_filter :login_required, :only => [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to projects_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated account."
      redirect_to projects_url
    else
      render :action => 'edit'
    end
  end
end
