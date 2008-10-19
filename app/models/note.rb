class Note < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  
  validates_presence_of :name, :content
  
  attr_accessible :name, :content
end
