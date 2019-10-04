class Leagues::MatchOutecomesController < ApplicationController

  before_action :authenticate_user!

  def new
    @user = current_user
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = Match.friendly.find(params[:match_id])
    @participant_one = Participant.find(@match.match_relationships.first.participant_id)
    @user_one = User.friendly.find(@participant_one.user_id)
    @participant_two = Participant.find(@match.match_relationships.last.participant_id)
    @user_two = User.friendly.find(@participant_two.user_id)
    @match_vote = MatchVote.new
  end
  
  def create
    @user = current_user
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = Match.friendly.find(params[:match_id])
    @participant_one = Participant.find(@match.match_relationships.first.participant_id)
    @participant_two = Participant.find(@match.match_relationships.last.participant_id)
    @match_vote = MatchVote.new(vote_params)
    @match_vote.match_id = @match.id
    if @match_vote.save
      redirect_to game_playlist_league_week_match_path(@game, @playlist, @league, @week, @match)
    else
      render 'new'
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

    private

      def vote_params
        params.permit(:match_id, :participant_id, :user_id)
      end

end