Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  
  resources :lectures, :member => {:package => :get}, :collection => {:search => :post} do
    resources :images, :collection => {:update_positions => :post}
    resources :comments
  end  
  
  resources :users, :identify => :login
  resources :lecturers
  
  resources :faculties, :identify => :code
  
  slice(:merb_auth_slice_password, :name_prefix => nil, :path_prefix => "")
  
  match("/profile").to(:controller => "users", :action => "edit").name(:profile)
  match("/:faculty").to(:controller => "lectures", :action => "index").name(:faculty)
  match("/").to(:controller => 'faculties', :action =>'index').name(:homepage)
end