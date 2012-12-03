if Rails::VERSION::MAJOR >= 3
  RedmineApp::Application.routes.draw do
    match 'my/avatar', :to => "my#avatar", :via => [:get, :post]
    match 'my/save_avatar', :to => "my#save_avatar", :via => [:post]
    match 'users/:id/save_avatar', :to => "users#save_avatar", :via => [:post]
    match 'account/avatar/:id', :to => "account#avatar", :via => [:get]
  end
else
  ActionController::Routing::Routes.draw do |map|
    map.connect 'my/avatar', 
      :controller => 'my', :action => 'avatar', 
      :conditions => {:method => [:get, :post]}
    map.connect 'my/save_avatar', 
      :controller => 'my', :action => 'save_avatar', 
      :conditions => {:method => [:post]}
    map.connect 'users/:id/save_avatar', 
      :controller => 'users', :action => 'save_avatar', 
      :id => /\d+/, :conditions => {:method => [:post]}
    map.connect 'account/avatar/:id', 
      :controller => 'account', :action => 'avatar', 
      :id => /\d+/, :conditions => {:method => [:get]}
  end
end

