class ActivitiesController < ApplicationController
  def index
    @activities = Activity.paginate(:per_page => 20, :page => params[:page])
  end
end
