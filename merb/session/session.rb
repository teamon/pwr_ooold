module Merb
  module Session
    
    def authenticated?
      Merb.logger.d user
      !user.nil?
    end
    
    def authenticate!(id, login)
      Merb.logger.d "session.authenticate!"
      self.user = User.get(id) || User.create(:id => id, :login => login)
      
      Merb.logger.d user
    end
    
    def destroy!
      self.user = nil
    end
    
    def user
      self[:user]
    end
    
    def user=(u)
      self[:user] = u
    end
    
  end
end