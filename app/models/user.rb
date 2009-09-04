class User
  include DataMapper::Resource
  
  property :id,     Serial
  property :login,  String, :nullable => false, :unique => true, 
      :format => /^[a-zA-Z0-9\-_]+$/, :length => 3..20
  property :email,  String, :nullable => false, :unique => true
  property :name,   String, :format => /^[a-zA-Z ]*$/
  property :admin,  Boolean, :default => false
  property :year,   Integer, :set => 1..5
  
  belongs_to :faculty  
  validates_present :faculty
  
  has n, :lectures
  has n, :comments

end
