module ControllerMacros
  def self.included(base)
    base.extend ClassMethods
  end
  
  def login
    session[:user_id] = User.first.id
  end
  
  module ClassMethods
    def it_should_require_login_for_actions(*actions)
      actions.each do |action|
        it "#{action} action should require login" do
          get action, :id => 1, :project_id => 1 # so routes work for those requiring id
          response.should redirect_to(login_url)
        end
      end
    end
  end
end
