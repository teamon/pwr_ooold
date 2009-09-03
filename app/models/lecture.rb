class Lecture
  include DataMapper::Resource
  
  property :id,   Serial
  property :name, String, :nullable => false
  property :description, Text
  property :date, DateTime
  property :created_at, DateTime
  
  validates_present :faculty
  validates_present :user
  
  belongs_to :faculty
  belongs_to :user
  
  has n, :images
  
  before :destroy do
    self.images.each {|i| i.destroy }
  end
  
  def package
    path = Merb.root / :public / :packages / "#{self.id}.zip"
    name = "#{self.id}-#{self.name.to_permalink}"
        
    unless File.exist?(path)
      Zip::ZipFile.open(path, Zip::ZipFile::CREATE) do |zip|
        zip.mkdir(name)
                
        images.in_order.each_with_index do |image, index|
          ext = image.filename.split(".").last
          zip.get_output_stream("#{name}/#{index+1}.#{ext}") {|f| f.write File.read(Merb.root / :public / image.url)}
        end
      end
    end
    
    [path, {:filename => name }]
  end
  
  
  def self.recent
    all(:order => [:created_at.desc])
  end
  
  def self.in_order
    all(:order => [:date.desc])
  end

end
