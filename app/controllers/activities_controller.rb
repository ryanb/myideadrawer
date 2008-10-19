class ActivitiesController < ApplicationController
  def index
    @activities = current_project.activities.all(:limit => 20)
  end
end
