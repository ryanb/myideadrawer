class Screenshot < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  
  validates_presence_of :name
  
  attr_accessible :name, :source_url
  
  before_save :add_protocol_to_source_url
  
  def image_url(width)
    "http://api.thumbalizr.com?api_key=#{APP_CONFIG['thumbalizr_key']}&url=#{source_url}&width=#{width}"
  end
  
  private
  
  def add_protocol_to_source_url
    self.source_url = "http://#{source_url}" unless source_url.blank? || source_url.include?('://')
  end
end
