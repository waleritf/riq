class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def new
    @playlist = Playlist.new
  end

  def create
    playlist = Playlist.new(title: playlist_params[:title])
    playlist.tracks << Track.where(id: params[:tracks])
    playlist = PlaylistFileGenerator.new(playlist).perform
    playlist.save!

    redirect_to playlists_path
  end

  def destroy
    Playlist.find(params[:id]).destroy!
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title)
  end
end
