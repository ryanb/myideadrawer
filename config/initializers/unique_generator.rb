module UniqueGenerator
  def self.included(base)
    base.extend ClassMethods
  end
  
  def ensure_unique(name)
    begin
      self[name] = yield
    end while self.class.exists?(name => self[name])
  end
  
  module ClassMethods
    def generate_unique(*names)
      names.each do |name|
        class_eval <<-SRC
          before_create :generate_unique_#{name}
          
          def generate_unique_#{name}
            ensure_unique(:#{name}) do
              String.random_string(10)
            end
          end
          
          def self.with_#{name}(value)
            find_by_#{name}(value) || raise(ActiveRecord::RecordNotFound)
          end
        SRC
      end
    end
  end
end


class ActiveRecord::Base
  include UniqueGenerator
end
