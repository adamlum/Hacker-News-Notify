ActionController::Routing::Routes.draw do |map|
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.signup "signup", :controller => "users", :action => "new"
  map.add "add", :controller => "watchlist", :action => "add"
  map.testemail "test_email", :controller => "static", :action => "test_email"
  map.profile "profile", :controller => "users", :action => "edit"
  map.validate "validate", :controller => "validate", :action => "index"
  map.rss "rss", :controller => "rss", :action => "index"
  map.delete "delete", :controller => "watchlist", :action => "delete"
  map.delete "toggle", :controller => "watchlist", :action => "toggle_notification"
  map.resources :user_sessions
  map.resources :users
  map.resources :watchlist
  map.root :controller => "static", :action => "index"
end
