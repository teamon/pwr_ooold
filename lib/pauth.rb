class PAuth
  class Error < Exception; end
  
  cattr_accessor :consumer_key, :consumer_secret, :host, :port, :login_path,
                 :request_token_path, :access_token_path, :data_path
  
  attr_accessor :token, :secret, :type
  
  def initialize(token = nil, secret = nil)
    @token, @secret = token, secret
    @http = Net::HTTP.new(@@host, @@port)
  end
  
  def get_request_token!
    json = make_request(@@request_token_path, consumer_params)
    self.token = json[:token]
    self.secret = json[:secret]
    self.type = :request 
  end
  
  def get_access_token!
    json = make_request(@@access_token_path, params)
    self.token = json[:token]
    self.secret = json[:secret]
    self.type = :access
  end
  
  def get_data
    json = make_request(@@data_path, params)
  end
  
  def login_path
    "http://" + @@host + (@@port.blank? ? "" : ":#{@@port}" ) + make_path(@@login_path, params)
  end
  
  def self.configure
    yield(self)
  end
  
  protected
  
  def make_request(path, params)
    request = @http.get(make_path(path, params))
    
    if request.code.to_i == 200
      puts request.body
      begin
        JSON.parse(request.body).to_mash 
      rescue
        # TODO: send notification!
        raise Error.new("Auth server problem. Please contact with admin")
      end
    else
      raise Error.new(request.msg)
    end
  end
  
  def make_path(path, params = {})
    path + (path =~ /\?/ ? "&" : "?") + params.to_params
  end
  
  def params
    consumer_params.merge(:token => token, :secret => secret)
  end
  
  def consumer_params
    { :consumer_key => @@consumer_key, :consumer_secret => @@consumer_secret }
  end
end
