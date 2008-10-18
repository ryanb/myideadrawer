class SessionsController < ApplicationController
  def new
  end
  
  def create
    if using_open_id?
      open_id_authentication
    else
      password_authentication
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
  
  private
  
  def password_authentication
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully."
      redirect_to projects_url
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end
  
  def open_id_authentication
    authenticate_with_open_id(params[:openid_url], :required => [:nickname, :email], :optional => :fullname) do |result, openid_url, registration|
      if result.successful?
        user = User.find_by_openid_url(openid_url)
        if user
          session[:user_id] = user.id
          flash[:notice] = "Logged in successfully."
          redirect_to projects_url
        else
          session[:openid_attributes] = registration.merge('openid_url' => openid_url)
          flash[:notice] = "It looks like you don't have an account yet, please create one below."
          redirect_to signup_path
        end
      else
        flash.now[:error] = result.message
        render :action => 'new'
      end
    end
  end
end
