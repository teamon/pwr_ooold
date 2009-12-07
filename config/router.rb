Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  add_slice(:merb_admin, :path_prefix => "admin")
  
  resources :lectures, :member => {:package => :get}, :collection => {:search => :post} do
    resources :images, :collection => {:update_positions => :post}
    resources :comments
  end  
  
  resources :users, :identify => :login
  resources :lecturers
  
  resources :faculties, :identify => :code
  
  
  with(:controller => "auth") do
    match("/login").to(:action => "login").name(:login)
    match("/logout").to(:action => "logout").name(:logout)
    match("/auth/callback").to(:action => "callback")
  end

  
  match("/profile").to(:controller => "users", :action => "edit").name(:profile)
  match("/:faculty").to(:controller => "lectures", :action => "index").name(:faculty)
  match("/").to(:controller => 'faculties', :action =>'index').name(:homepage)
end