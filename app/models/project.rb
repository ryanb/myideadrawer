class Project < ActiveRecord::Base
  belongs_to :user
  has_many :notes
  has_many :activities
  has_many :links
  has_many :code_snippets
  
  generate_unique :token
  
  def to_s
    name
  end
  
  def self.fetch(user, id_or_token)
    Project.find_by_token(id_or_token) || user.projects.find(id_or_token)
  end
end
