class Link < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  
  validates_presence_of :name, :url
  
  def to_s
    name
  end
end
