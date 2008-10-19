class CodeSnippet < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  
  validates_presence_of :name, :content, :language
  
  attr_accessible :name, :content, :language
end
