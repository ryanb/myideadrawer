class CodeSnippet < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  
  validates_presence_of :name, :content, :language
  
  def to_s
    name
  end
end
