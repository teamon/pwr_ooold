class Comment
  include DataMapper::Resource
  
  property :id, Serial
  property :content, Text, :nullable => false
  property :created_at, DateTime

  belongs_to :user
  belongs_to :lecture
  
  def self.chronologically
    all(:order => [:created_at.asc])
  end
  
  def self.recent
    all(:order => [:created_at.desc])
  end

end
