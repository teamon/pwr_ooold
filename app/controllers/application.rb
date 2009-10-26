class Application < Merb::Controller
  
  protected
  
  def ensure_authenticated
    unless session.authenticated?
      session[:redirect_to] = request.uri
      raise Unauthorized
    end
  end
end