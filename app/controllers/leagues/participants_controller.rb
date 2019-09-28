class Leagues::ParticipantsController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @user = current_user
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @participant = Participant.new
    @participant.user_id = @user.id
    @participant.league_id = @league.id
    if @participant.save
      redirect_to game_playlist_league_path(@game, @playlist, @league)
      #respond_to do |format|
       #format.html { redirect_to user_video_path(@user, @video) }
       #format.js { render :action => "adds" }
       #flash.now[:notice] = "You have successfully added #{@video.title} to #{@playlist.title}!"
      #end
    else
      redirect_to game_playlist_league_path(@game, @playlist, @league)
      flash[:alert] = "You have failed."
    end
  end

  def destroy
    @user = User.friendly.find(params[:user_id])
    @game = Game.friendly.find(params[:game_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @league = League.friendly.find(params[:league_id])
    @participant = Participant.find(params[:id]).destroy
    #respond_to do |format|
    #  format.html { redirect_to user_playlist_path(@user, @playlist) }
    #  format.js { render :action => "adds" }
    #  flash.now[:notice] = "You removed #{@video.title} from #{@playlist.title}!"
    #end
  end

end