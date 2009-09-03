class Faculty
  include DataMapper::Resource
  
  property :id,   Serial
  property :code, String, :nullable => false, :unique => true
  property :name, String, :nullable => false
  
  def self.by_code
    all(:order => [:code.asc])
  end

end
