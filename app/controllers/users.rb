class Users < Application
  # provides :xml, :yaml, :js

  # def index
  #   @users = User.all
  #   display @users
  # end

  def show(id)
    @user = User.get(id)
    raise NotFound unless @user
    display @user
  end

  def new
    redirect url(:login)
  end

  # def edit(id)
  #   only_provides :html
  #   @user = User.get(id)
  #   raise NotFound unless @user
  #   display @user
  # end

  def create(user)
    Merb.logger.d user
    @new_user = User.new(user)
    if @new_user.save
      redirect resource(@new_user), :message => {:notice => "User was successfully created"}
    else
      render :template => 'exceptions/unauthenticated'
    end
  end

  # def update(id, user)
  #   @user = User.get(id)
  #   raise NotFound unless @user
  #   if @user.update_attributes(user)
  #      redirect resource(@user)
  #   else
  #     display @user, :edit
  #   end
  # end
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
