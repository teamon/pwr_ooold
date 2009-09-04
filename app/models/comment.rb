class Comment
  include DataMapper::Resource
  
  property :id, Serial
  property :content, Text, :nullable => false
  property :created_at, DateTime

  belongs_to :user
  belongs_to :lecture
  
  def self.in_order(opts = {})
    all({:order => [:created_at.asc]}.merge(opts))
  end
  
  def self.recent(opts = {})
    all({:order => [:created_at.desc]}.merge(opts))
  end

end
