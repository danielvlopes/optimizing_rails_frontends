ActionController::Routing::Routes.draw do |map|
  Jammit::Routes.draw(map)  
  map.resources :posts, :has_many => :comments
  map.root :controller => "posts"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
