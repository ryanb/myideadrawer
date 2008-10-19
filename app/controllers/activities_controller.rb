class ActivitiesController < ApplicationController
  def index
    @activities = current_project.activities.paginate(:per_page => 20, :page => params[:page])
  end
end
