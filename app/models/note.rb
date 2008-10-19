class Note < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  
  validates_presence_of :name, :content
  
  def to_s
    name
  end
end
