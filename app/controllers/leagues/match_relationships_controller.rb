class Leagues::MatchRelationshipsController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = Match.friendly.find(params[:match_id])
    @participant = Participant.find(3)
    @match_relationship = MatchRelationship.new
    @match_relationship.participant_id = @participant.id
    @match_relationship.match_id = @match.id
    @match_relationship.league_id = @league.id
    if @match_relationship.save
      redirect_to game_playlist_league_week_match_path(@game, @playlist, @league, @week, @match)
    else
      redirect_to game_playlist_league_week_match_path(@game, @playlist, @league, @week, @match)
      flash[:alert] = "You have failed."
    end
  end

  def destroy
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = Match.friendly.find(params[:match_id])
    @participant = Participant.find(params[:participant_id])
    @match_relationship = MatchRelationship.find(params[:id]).destroy
  end

end