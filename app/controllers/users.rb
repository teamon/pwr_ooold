class Users < Application

  before :ensure_authenticated, :only => [:edit, :update]
  params_protected :user => [:admin]

  def show(login)
    @user = User.first(:login => login)
    raise NotFound unless @user
    @lectures = @user.lectures
    @comments = @user.comments
    display @user
  end

end # Users
