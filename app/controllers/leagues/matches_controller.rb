class Leagues::MatchesController < ApplicationController

  before_action :authenticate_admin, except: :show

  def show
    @user = current_user if user_signed_in?
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = Match.friendly.find(params[:id])
    @match_relationship = MatchRelationship.new
    @participant_one = Participant.find(@match.match_relationships.first.participant_id)
    @user_one = User.friendly.find(@participant_one.user_id)
    @participant_two = Participant.find(@match.match_relationships.last.participant_id)
    @user_two = User.friendly.find(@participant_two.user_id)
  end

  def new
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = Match.new
  end

  def create
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = @week.matches.build(match_params)
    if @match.save
      flash[:notice] = "You just created " + @match.title + "!"
      redirect_to game_playlist_league_week_match_path(@game, @playlist, @league, @week, @match)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = Match.friendly.find(params[:id])
  end

  def update
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = Match.friendly.find(params[:id])
    if @match.update_attributes(match_params)
      flash[:notice] = "Good job!"
      redirect_to game_playlist_league_week_path(@game, @playlist, @league, @week)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = Match.friendly.find(params[:id]).destroy
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

    def match_params
      params.require(:match).permit(:participant_one_id, :participant_two_id, :title, :description, :image)
    end

end