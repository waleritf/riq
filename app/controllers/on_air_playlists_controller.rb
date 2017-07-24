class OnAirPlaylistsController < ApplicationController
  def create
    return if transmission_busy?

    post_request = Net::HTTP::Post.new(HARBOR[:set_playlist])
    post_request.body = playlist.file.path

    harbor.request(post_request)
    playlist.update!(on_air: true)
  end

  def destroy
    stop_transmission!

    playlist_on_air.update!(on_air: false) if transmission_busy?
  end

  private

  def playlist
    @playlist ||= Playlist.find(params[:playlist_id])
  end

  def harbor
    @harbor ||= Net::HTTP.new(HARBOR[:host], HARBOR[:port])
  end

  def stop_transmission!
    delete_request = Net::HTTP::Delete.new(HARBOR[:stop_transmission])
    harbor.request(delete_request)
  end

  def transmission_busy?
    playlist_on_air.present?
  end
end
