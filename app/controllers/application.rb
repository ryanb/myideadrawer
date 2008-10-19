# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  
  helper_method :current_project, :owner?
  
  private
  
  def record_activity(message, project = nil, user = nil)
    project ||= @project || current_project
    user ||= current_user
    Activity.create! :message => message, :project => project, :user => user
    project.update_attribute(:last_activity_at, Time.now) if project && !project.frozen?
  end
  
  def current_project
    @project ||= Project.fetch(current_user, params[:project_id])
  end
  
  def owner?
    current_user.id == current_project.user_id
  end
end
