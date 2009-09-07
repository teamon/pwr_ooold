class Faculty
  include DataMapper::Resource
  
  property :id,   Serial
  property :code, String
  property :name, String, :nullable => false

  has n, :lectures

  def full_name
    "#{code} #{name}"
  end
  
  # def full_name_with_lectures_count
  #   "#{full_name} <span>(#{lectures.count})</span>"
  # end
  
end
