ActionController::Routing::Routes.draw do |map|
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.home 'home', :controller => 'projects', :action => 'index'
  map.about 'about', :controller => 'welcome', :action => 'about'
  map.help 'help', :controller => 'welcome', :action => 'about'
  map.resources :activities
  map.resources :sessions
  map.resources :users
  map.resources :projects do |project|
    project.resources :notes
  end

  map.root :controller => 'welcome'
end
