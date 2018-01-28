class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @commented_restaurants = @user.restaurants
    @favorited_restaurants = @user.favorited_restaurants
    @followings = @user.followings
    @followers = @user.followers
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to user_path
    else
      @users = User.all
      render :index
    end
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def index
    @users = User.all
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
