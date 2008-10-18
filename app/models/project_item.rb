module ProjectItem
  def self.included(base)
    base.named_scope :recent, lambda { |limit| { :order => 'created_at DESC', :limit => limit } }
  end
end