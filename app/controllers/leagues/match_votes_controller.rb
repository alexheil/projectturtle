class Leagues::MatchVotesController < ApplicationController

  before_action :authenticate_user!
  before_action :vote_user_is_participant, only: :create

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

      #check to see if a participant has enough votes to win 
      if @participant_one.match_vote_id(@match).count == 2
        create_match_outcome(@match)
      elsif @participant_two.match_vote_id(@match).count == 2
        create_match_outcome(@match)
      else
        puts "need more votes"
      end

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

      def create_match_outcome(match)
        @user = current_user
        @game = Game.friendly.find(params[:game_id])
        @playlist = Playlist.friendly.find(params[:playlist_id])
        @league = League.friendly.find(params[:league_id])
        @week = Week.friendly.find(params[:week_id])
        @match = Match.friendly.find(params[:match_id])
        @participant_one = Participant.find(@match.match_relationships.first.participant_id)
        @participant_two = Participant.find(@match.match_relationships.last.participant_id)

        #which participant has enough votes? create match outcome
        if @participant_one.match_vote_id(@match).count == 2
          MatchOutcome.create(
            match_id: @match.id,
            participant_id: @participant_one.id
            )
          puts "match outcome created for #{@participant_one.user.username}"
        elsif @participant_two.match_vote_id(@match).count == 2
          MatchOutcome.create(
            match_id: @match.id,
            participant_id: @participant_two.id
            )
          puts "match outcome created for #{@participant_two.user.username}"
        end

      end

      # check that voters are participants
      def vote_user_is_participant
        @user = current_user
        @game = Game.friendly.find(params[:game_id])
        @playlist = Playlist.friendly.find(params[:playlist_id])
        @league = League.friendly.find(params[:league_id])
        @week = Week.friendly.find(params[:week_id])
        @match = Match.friendly.find(params[:match_id])
        @participant_one = Participant.find(@match.match_relationships.first.participant_id)
        @participant_two = Participant.find(@match.match_relationships.last.participant_id)

        unless (@user.id == @participant_one.user_id) || (@user.id == @participant_two.user_id)
          redirect_to root_url
          flash[:alert] = "You are not the correct user."
        end
      end

      def vote_params
        params.permit(:match_id, :participant_id, :user_id)
      end

end