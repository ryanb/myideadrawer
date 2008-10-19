class Project < ActiveRecord::Base
  belongs_to :user
  has_many :activities, :dependent => :nullify
  has_many :notes, :dependent => :destroy
  has_many :links, :dependent => :destroy
  has_many :code_snippets, :dependent => :destroy
  has_many :palettes, :dependent => :destroy
  has_many :screenshots, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  
  generate_unique :token
  
  validates_presence_of :name
  
  def self.fetch(user, id_or_token)
    Project.find_by_token(id_or_token) || (user || User.new).projects.find(id_or_token)
  end
end
