class Activity < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  belongs_to :user
end
