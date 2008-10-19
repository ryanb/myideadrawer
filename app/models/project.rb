class Project < ActiveRecord::Base
  belongs_to :user
  has_many :notes
  has_many :activities
  has_many :links
  has_many :code_snippets
  has_many :palettes
  has_many :screenshots
  has_many :photos
  
  generate_unique :token
  
  validates_presence_of :name
  
  def to_s
    name
  end
  
  def self.fetch(user, id_or_token)
    Project.find_by_token(id_or_token) || (user || User.new).projects.find(id_or_token)
  end
end
