class Faculty
  include DataMapper::Resource
  
  property :id,   Serial
  property :name, String, :nullable => false

  def full_name
    "#{id == 0 ? "SKP" : "W#{id}"} #{name}"
  end
  
end
