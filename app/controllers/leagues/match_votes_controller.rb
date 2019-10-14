class Leagues::MatchVotesController < ApplicationController

  before_action :authenticate_user!
  before_action :vote_user_is_participant, only: :create
  before_action :not_able_to_unvote, only: :destroy

  def new
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

      #create proof that match deserves vote
      @match_proof = MatchProof.new(proof_params)
      @match_proof.match_id = @match.id
      @match_proof.match_vote_id = @match_vote.id

      if @match_proof.save

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
        current_user.unvote(@match)
        redirect_to game_playlist_league_week_match_path(@game, @playlist, @league, @week, @match)
        flash[:alert] = "You have failed."
      end

    end

  end

  def destroy
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @week = Week.friendly.find(params[:week_id])
    @match = Match.friendly.find(params[:match_id])
    @match_vote = MatchVote.find(params[:id])
    current_user.unvote(@match)
    redirect_to game_playlist_league_week_match_path(@game, @playlist, @league, @week, @match)
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
            league_id: @league.id,
            participant_id: @participant_one.id
          )
        elsif @participant_two.match_vote_id(@match).count == 2
          MatchOutcome.create(
            match_id: @match.id,
            league_id: @league.id,
            participant_id: @participant_two.id
          )
        end

      end

      # check that voters are participants
      def vote_user_is_participant
        @user = current_user
        @owner = User.friendly.find(1)
        @game = Game.friendly.find(params[:game_id])
        @playlist = Playlist.friendly.find(params[:playlist_id])
        @league = League.friendly.find(params[:league_id])
        @week = Week.friendly.find(params[:week_id])
        @match = Match.friendly.find(params[:match_id])
        @participant_one = Participant.find(@match.match_relationships.first.participant_id)
        @participant_two = Participant.find(@match.match_relationships.last.participant_id)

        unless (@user.id == @participant_one.user_id) || (@user.id == @participant_two.user_id) || (@user == @owner)
          redirect_to root_url
          flash[:alert] = "You are not the correct user."
        end
      end

      def vote_params
        params.permit(:match_id, :participant_id, :user_id)
      end

      def proof_params
        params.require(:match_proof).permit(:image, :remove_image, :description)
      end

      # give certain amount of time until you cannot unvote
      def not_able_to_unvote
        @match_vote = MatchVote.find(params[:id])
        if @match_vote.created_at <= Time.now - 5.minutes
          redirect_to root_url
        end
      end

end