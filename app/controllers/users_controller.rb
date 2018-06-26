class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user)  
    else
      render :new
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    current_user.destroy
    flash[:success] = 'User was successfully destroyed'
    redirect_to users_path
  end

  private
    def current_user
      @user ||= User.find(params[:id])
    end  

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
