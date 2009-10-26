class User
  include DataMapper::Resource
  
  property :id,     Serial
  property :login,  String, :nullable => false, :unique => true, 
      :format => /^[a-zA-Z0-9\-_]+$/, :length => 3..20
  
  has n, :lectures
  has n, :comments

end
