class Leagues::WeeksController < ApplicationController

  before_action :authenticate_admin, except: :show

  def show
    @user = current_user if user_signed_in?
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:id])
    @matches = @week.matches
  end

  def new
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.new
  end

  def create
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])

    while @league.weeks.count <= @league.number_of_weeks
      Week.create(
        league_id: @league.id,
        title: "Week " + (@league.weeks.count + 1).to_s
      )
    end

    if @league.weeks.count == @league.number_of_weeks
      redirect_to game_playlist_league_path(@game, @playlist, @league)
    else
      redirect_to root_url
    end
  end

  def edit
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:id])
  end

  def update
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:id])
    if @week.update_attributes(week_params)
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
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:id]).destroy
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

    def week_params
      params.require(:week).permit(:title, :description, :image)
    end

end