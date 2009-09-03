class Lecture
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :nullable => false
  property :date, DateTime
  
  belongs_to :faculty
  belongs_to :user
  
  validates_present :faculty
  validates_present :user

end
