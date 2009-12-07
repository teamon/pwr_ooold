class Application < Merb::Controller
  
  before do
    if params[:lecture] && params[:lecture][:date]
      params[:lecture][:date] = params[:lecture][:date].inject({}){|h, (k,v)| h[k] = v.to_i; h } rescue nil
    end
  end

  protected

  def ensure_authenticated
    unless session.authenticated?
      session[:redirect_to] = request.uri
      raise Unauthorized
    end
  end
end