class Photo < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  
  has_attached_file :image,
    :url => "/assets/photos/:id/:style/:basename.:extension",
    :path => "#{RAILS_ROOT}/public/assets/photos/:id/:style/:basename.:extension" 
  
  def to_s
    name
  end
end
