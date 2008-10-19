# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  
  helper_method :current_project, :owner?, :project_param
  
  private
  
  def current_project
    @project ||= Project.fetch(current_user, project_param)
  end
  
  def owner?
    logged_in? && current_user.id == current_project.user_id
  end
  
  def project_param
    params[:project_id] || params[:id]
  end
  
  def owner_required
    if !logged_in?
      login_required
    elsif !owner?
      flash[:error] = "Unauthorized access. You must be the owner of this project to do that."
      redirect_to project_url(params[:project_id])
    end
  end
  
  def record_activity(target = nil, container = nil)
    message_generator = ActivityMessageGenerator.new(@template)
    message_generator.target = target || current_project
    message_generator.container = container || current_project unless target == current_project
    message_generator.action = params[:action].to_sym
    Activity.create! :message => message_generator.message, :project => current_project, :user => current_user
    current_project.update_attribute(:last_activity_at, Time.now) unless current_project.frozen?
  end
end
