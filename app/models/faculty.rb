class Faculty
  include DataMapper::Resource
  
  property :id,   Serial
  property :name, String, :nullable => false

  has n, :lectures
  
  def code
    id == 0 ? "SKP" : "W#{id}"
  end

  def full_name
    "#{code} #{name}"
  end
  
  def full_name_with_lectures_count
    "#{full_name} <span>(#{lectures.count})</span>"
  end
  
end
