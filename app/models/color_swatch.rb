class ColorSwatch < ActiveRecord::Base
  belongs_to :palette
  
  validates_presence_of :hex
end
