class Leagues::LeaguesController < ApplicationController

  before_action :authenticate_admin, except: :show

  def show
    @user = current_user if user_signed_in?
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:id])
    @participant = Participant.new
  end

  def new
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.new
  end

  def create
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = @playlist.leagues.build(league_params)
    if @league.save
      flash[:notice] = "You just created " + @league.title + "!"
      redirect_to game_playlist_league_path(@game, @playlist, @league)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:id])
  end

  def update
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:id])
    if @league.update_attributes(league_params)
      flash[:notice] = "Good job!"
      redirect_to game_playlist_league_path(@game, @playlist, @league)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:id]).destroy
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

    def league_params
      params.require(:league).permit(:title, :description, :image, :number_of_participants, :number_of_weeks, :number_of_matches)
    end

end