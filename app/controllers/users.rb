class Users < Application
  # provides :xml, :yaml, :js

  before :ensure_authenticated, :only => [:edit, :update]
  params_protected :user => [:admin]

  def index
    @users = User.all
    display @users
  end

  def show(login)
    @user = User.first(:login => login)
    raise NotFound unless @user
    @lectures = @user.lectures
    @comments = @user.comments
    raise NotFound unless @user
    display @user
  end

  def new
    redirect url(:login)
  end

  def edit
    only_provides :html
    @user = session.user
    @lectures = @user.lectures
    display @user
  end

  def create(user)
    @new_user = User.new(user)
    if @new_user.save
      redirect resource(@new_user), :message => "Rejestracja zakończona pomyślnie"
    else
      render :template => 'exceptions/unauthenticated'
    end
  end

  def update(user)
    @user = session.user
    if @user.update_attributes(user)
       redirect url(:profile), :message => "Zmiany w profilu zostały zapisane"
    else
      @lectures = @user.lectures
      display @user, :edit
    end
  end

end # Users
