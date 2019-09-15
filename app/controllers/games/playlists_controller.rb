class Games::PlaylistsController < ApplicationController

  before_action :authenticate_admin, except: :show

  def show
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:id])
    @leagues = @playlist.leagues
  end

  def new
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.new
  end

  def create
    @game = Game.friendly.find(params[:game_id])
    @playlist = @game.playlists.build(playlist_params)
    if @playlist.save
      flash[:notice] = "You just created " + @playlist.title + "!"
      redirect_to game_playlist_path(@game, @playlist)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:id])
  end

  def update
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:id])
    if @playlist.update_attributes(playlist_params)
      flash[:notice] = "Good job!"
      redirect_to game_playlist_path(@game, @playlist)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:id]).destroy
    redirect_to root_url
    flash[:notice] = "Delete successful."
  end

  private

    def authenticate_admin
      @owner = User.friendly.find(1)
      unless current_user == @owner
        redirect_to root_url
      end
    end

    def playlist_params
      params.require(:playlist).permit(:title, :description, :image)
    end

end