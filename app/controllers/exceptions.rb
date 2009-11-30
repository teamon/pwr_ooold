class Exceptions < Merb::Controller
  layout :application
  
  # handle NotFound exceptions (404)
  def not_found
    render :format => :html
  end

  # handle NotAcceptable exceptions (406)
  def not_acceptable
    render :format => :html
  end
  
  # handle Unauthenticated exception
  def unauthenticated
    @new_user = User.new
    render :format => :html
  end
  
  # handle Unauthorized exception (401)
  def unauthorized
    redirect url(:login)
  end

end