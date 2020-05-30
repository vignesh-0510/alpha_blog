class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to articles_path, notice: "Welcome to Alpha-blog, #{@user.username} you have successfully Signed up!"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to articles_path, notice: "Account was updated Successfully!"
    else
      render 'edit'
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def get_user
    User.find(params[:id])
  end
end