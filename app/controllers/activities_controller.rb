class ActivitiesController < ApplicationController
  before_filter :fetch_current_project
  
  def index
    @activities = current_project.activities.all(:limit => 20)
  end
end
