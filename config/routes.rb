ActionController::Routing::Routes.draw do |map|
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.home 'home', :controller => 'projects', :action => 'index'
  map.resources :sessions
  map.resources :users
  map.resources :notes
  map.resources :projects

  map.root :controller => 'welcome'
end
