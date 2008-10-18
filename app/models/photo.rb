class Photo < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  
  def to_s
    name
  end
end
