Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  
  resources :lectures, :member => {:package => :get} do
    resources :images, :collection => {:update_positions => :post}
  end  
  
  resources :users, :identify => :login
  
  resources :faculties do
    resources :lectures
  end
  
  slice(:merb_auth_slice_password, :name_prefix => nil, :path_prefix => "")
  
  authenticate do
    match("/profile").to(:controller => "users", :action => "edit").name(:profile)
  end
  
  match('/search/:query').to(:controller => "lectures", :action => "index").name(:search)
  match('/').to(:controller => 'faculties', :action =>'index').name(:homepage)
end