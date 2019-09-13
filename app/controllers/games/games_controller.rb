class Games::GamesController < ApplicationController  

  before_action :authenticate_user!, except: [:show, :index]
  before_action :correct_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_user
  #before_action :banned, except: [:show, :index]
  #before_action :confirmed, except: [:show, :index]

  def index
    @games = Game.all
  end

  def show
    @game = Game.friendly.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:notice] = "You just created a game!"
      redirect_to game_path(@game)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @game = Game.friendly.find(params[:id])
  end

  def update
    @game = Game.friendly.find(params[:id])
    if @game.update_attributes(game_params)
      flash[:notice] = "Good job!"
      redirect_to user_game_path(@user, @game)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @game = Game.friendly.find(params[:id]).destroy
    redirect_to root_url
    flash[:notice] = "Delete successful."
  end

  private

    def set_user
      @user = current_user
    end

    def correct_user
      @owner = User.friendly.find(1)
      @game = Game.friendly.find(params[:id])
      unless current_user == @owner
        redirect_to root_url
      end
    end

    def confirmed
      @user = current_user
      if @user.confirmed_at.blank?
        redirect_to root_url
      end
    end

    def banned
      @user = current_user
      if @user.banned?
        redirect_to root_url
      end
    end

    def game_params
      params.require(:game).permit(:note, :latitude, :longitude, :image, :remove_image)
    end

end