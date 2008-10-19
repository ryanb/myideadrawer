ActionController::Routing::Routes.draw do |map|
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.home 'home', :controller => 'projects', :action => 'index'
  map.about 'about', :controller => 'welcome', :action => 'about'
  map.help 'help', :controller => 'welcome', :action => 'about'
  map.resources :sessions
  map.resources :users
  map.resources :projects do |project|
    project.resources :screenshots, :collection => { :manage => :get }
    project.resources :photos, :collection => { :manage => :get }
    project.resources :notes
    project.resources :links
    project.resources :code_snippets
    project.resources :palettes
    project.resources :screenshots
    project.resources :photos
    project.resources :activities
  end
  map.root :controller => 'welcome'
end
