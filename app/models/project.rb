class Project < ActiveRecord::Base
  belongs_to :user
  has_many :notes
  has_many :activities
  
  generate_unique :token
  
  def to_s
    name
  end
end
