ActionController::Routing::Routes.draw do |map|
  map.resources :projects

  map.root :controller => 'welcome'
end
