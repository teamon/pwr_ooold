class Uploader
  @config = [ENV["SCP_HOST"], ENV["SCP_LOGIN"], {:password => ENV["SCP_PASSWORD"]}]
  @images = []
  
  class << self
    def upload!(image, file)
      @images << [:upload, image, file]
    end
    
    def delete!(image)
      @images << [:delete, image]
    end
    
    def start!
      Thread.new do
        
        loop do
          if @images.empty?
            sleep(1)
          else
            cmd = @images.shift
            
            case cmd[0]
            when :upload
              image, file = cmd[1], cmd[2]
              path = "/home/pewuer/upload/#{image.id}/"
        
              Net::SSH.start(*@config) do |ssh|
                ssh.exec!("mkdir -p #{path}")
              end
          
              Net::SCP.start(*@config) do |scp|
                scp.upload!(file[:tempfile].path, path + image.filename)
              end
          
              Net::SSH.start(*@config) do |ssh|
                ssh.exec!("cp #{path}#{image.filename} #{path}thumb_#{image.filename}")
              end
              
            when :delete
              image = cmd[1]
              path = "/home/pewuer/upload/#{image.id}/"
              Net::SSH.start(*@config) do |ssh|
                ssh.exec!("rm -r #{path}")
              end
            end
          end
        
        end
        
      end
    end
    
  end
end