class Project < ActiveRecord::Base
  belongs_to :user
  has_many :notes
  has_many :activites
  
  def to_s
    name
  end
end
