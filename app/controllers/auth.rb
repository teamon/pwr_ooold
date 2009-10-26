class Auth < Application
  def login
    auth = PAuth.new
    auth.get_request_token!
    
    Merb.logger.d auth
    
    session[:auth] = {
      :request_token => auth.token,
      :request_token_secret => auth.secret
    }
    
    redirect auth.login_path
  end
  
  def logout
    session.destroy!
    redirect "/"
  end
  
  def callback
    auth = PAuth.new(session[:auth][:request_token], session[:auth][:request_token_secret])
    auth.get_access_token!
    
    session[:auth] = {
      :access_token => auth.token,
      :access_token_secret => auth.secret
    }
    
    data = auth.get_data
    
    session.authenticate!(data[:id], data[:login])
    redirect_back_or "/"
  end
  
  protected
  
  def redirect_back_or(uri)
    redirect session[:redirect_to].blank? ? uri : session[:redirect_to]
  end
end