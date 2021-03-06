class Games::GamesController < ApplicationController  

  before_action :authenticate_admin, except: [:show, :index]
  before_action :set_user
  #before_action :banned, except: [:show, :index]
  #before_action :confirmed, except: [:show, :index]

  def index
    @games = Game.all
  end

  def show
    @game = Game.friendly.find(params[:id])
    @playlists = @game.playlists
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
      redirect_to game_path(@game)
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

    def authenticate_admin
      @owner = User.friendly.find(1)
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
      params.require(:game).permit(:title, :description, :image)
    end

end