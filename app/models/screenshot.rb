class Screenshot < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  
  validates_presence_of :name
  
  def to_s
    name
  end
  
  def image_url(width)
    "http://api.thumbalizr.com?api_key=#{APP_CONFIG['thumbalizr_key']}&url=#{source_url}&width=#{width}"
  end
end
