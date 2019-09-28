class Leagues::MatchVotesController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @user = current_user
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = Match.friendly.find(params[:match_id])
    @participant = Participant.find(params[:id])
    @match_vote = MatchVote.new
    @match_vote.user_id = @user.id
    @match_vote.participant_id = @participant.id
    @match_vote.match_id = @match.id
    if @match_vote.save
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
    @match_vote = MatchVote.find(params[:id])
  end

end