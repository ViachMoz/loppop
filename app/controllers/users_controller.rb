class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to user_path(@user), notice: 'User was successfully created'   
    else
      render :new
    end
  end

  def update
    if current_user.valid?
      current_user.update(user_params)
      redirect_to user_path, notice: 'User was successfully created'
    else
      render :new
    end
  end

  def destroy
    current_user.destroy
    redirect_to users_path, notice: 'User was successfully destroyed'
  end

  private
    def current_user
      @user = User.find(params[:id])
    end  
    
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
