class Note < ActiveRecord::Base
  belongs_to :project
  named_scope :recent, lambda { |limit| { :order => 'created_at DESC', :limit => limit } }
  
  def to_s
    name
  end
end
