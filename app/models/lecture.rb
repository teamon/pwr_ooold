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
  belongs_to :lecturer
  
  has n, :images
  has n, :comments
  
  before :destroy do
    self.images.each {|i| i.destroy }
    delete_package
  end
  
  def lecturer_name
    lecturer ? lecturer.name : ""
  end
  
  # lecturer.name rescue ""
  
  def lecturer_name=(name)
    unless name.blank?
      self.lecturer = Lecturer.first(:name => name) || Lecturer.create(:name => name)
    end
  end
  
  def package
    path, name = package_path_and_name
    create_package unless File.exist?(path)
    [path, {:filename => name }]
  end
  
  def create_package
    path, name = package_path_and_name
    delete_package
    
    Zip::ZipFile.open(path, Zip::ZipFile::CREATE) do |zip|
      zip.mkdir(name)
              
      images.in_order.each_with_index do |image, index|
        ext = image.filename.split(".").last
        zip.get_output_stream("#{name}/#{index+1}.#{ext}") {|f| f.write File.read(Merb.root / :public / image.url)}
      end
    end
    
    [path, {:filename => name }]
  end
  
  def delete_package
    path, name = package_path_and_name
    File.delete(path) if File.exist?(path)
  end
  
  def package_size
    path, name = package_path_and_name
    File.exist?(path) ? File.size(path) : 0
  end
  
  def author?(user)
    self.user == user
  end
  
  def package_path_and_name
    [Merb.root / :public / :packages / "#{self.id}.zip", "#{self.id}-#{self.name.to_permalink}"]
  end
  
  
  def self.recent
    all(:order => [:created_at.desc])
  end
  
  def self.chronologically
    all(:order => [:date.desc])
  end

end
