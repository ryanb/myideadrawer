class Link < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  
  validates_presence_of :name, :url
  
  before_save :add_protocol_to_url
  
  private
  
  def add_protocol_to_url
    self.url = "http://#{url}" unless url.blank? || url.include?('://')
  end
end
