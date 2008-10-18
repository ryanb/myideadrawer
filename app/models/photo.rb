class Photo < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  
  has_attached_file :image, :styles => { :small => "150x150>", :tiny => "64x64>" },
    :url => "/assets/photos/:id/:style/:basename.:extension",
    :path => "#{RAILS_ROOT}/public/assets/photos/:id/:style/:basename.:extension" 
  
  def to_s
    name
  end
  
  def image_width(style = nil)
    image_jpeg(style).width
  end
  
  def image_height(style = nil)
    image_jpeg(style).height
  end
  
  def image_size(style = nil)
    [image_width(style), image_height(style)].join('x')
  end
  
  private
  
  def image_jpeg(style = nil)
    @jpegs ||= Hash.new
    @jpegs[style] ||= JPEG.new(image.path(style))
  end
end
