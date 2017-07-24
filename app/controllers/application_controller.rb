class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def playlist_on_air
    @on_air_playlist ||= Playlist.on_air
  end
  helper_method :playlist_on_air
end
