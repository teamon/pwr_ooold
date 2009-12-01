class Image
  include DataMapper::Resource
  
  property :id, Serial
  property :content_type, String
  property :size, Integer
  property :filename, String
  property :position, Integer
  
  belongs_to :lecture
  
  def self.create(opts = {})
    file = opts[:filedata]
    unless file.empty?
      obj = new(:filename => file[:filename], 
                :content_type => file[:content_type],
                :size => file[:size])
      obj.lecture = opts[:lecture]
      obj.save
      
      Uploader.upload!(obj, file)
      
      # Dir.mkdir(Merb.root / :public / :uploads / obj.id)
      # File.open(Merb.root / :public / obj.url, "wb") {|f| f.write file[:tempfile].read }
      # mm = MiniMagick::Image.from_file(Merb.root / :public / obj.url)
      # mm.resize("100x100")
      # mm.write(Merb.root / :public / obj.url(:thumbnail))
      # obj.lecture.create_package
      
      obj
    end
  rescue Exception => e
    Merb.logger.error e
    obj.destroy    
  end
  
  def self.ordered
    all(:order => [:position.asc])
  end
    
  before :destroy do
    Uploader.delete!(self)
  end
  
  def url(type = nil)
    "/uploads/#{self.id}/#{type}#{self.filename}"
  end

end
