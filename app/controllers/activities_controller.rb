class ActivitiesController < ApplicationController
  def index
    @activities = Activity.find(:all)
  end
end
