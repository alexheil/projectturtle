class Users::UsersController < ApplicationController
  
  before_action :authenticate_user!, only: :update
  before_action :correct_user, only: :update

  def show
    @owner = User.friendly.find(1)
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Good job!"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = 'Bad job!'
      redirect_to user_path(@user)
    end
  end

  private

    def correct_user
      @owner = User.friendly.find(1)
      @user = User.friendly.find(params[:id])
      unless current_user == @user || current_user == @owner
        redirect_to root_url
      end
    end

    def user_params
      params.require(:user).permit(:banned, :verified)
    end
  
end