class Users < Application
  # provides :xml, :yaml, :js

  before :ensure_authenticated, :only => [:edit, :update]

  # def index
  #   @users = User.all
  #   display @users
  # end

  def show(login)
    @user = User.first(:login => login)
    @lectures = @user.lectures
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
      redirect resource(@new_user), :message => {:notice => "User was successfully created"}
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
  # 
  # def destroy(id)
  #   @user = User.get(id)
  #   raise NotFound unless @user
  #   if @user.destroy
  #     redirect resource(:users)
  #   else
  #     raise InternalServerError
  #   end
  # end

end # Users
