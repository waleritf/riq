class TracksController < ApplicationController
  before_action :create_artist_if_needed, only: [:create]
  before_action :create_album_if_needed, only: [:create]

  def index
    @tracks = Track.all
  end

  def new
    @track = Track.new
  end

  def create
    track = Track.new(track_params)
    track.title = track_metadata[:title] || Track::DEFAULT_TITLE
    track.duration = track_metadata[:duration]
    track.assign_attributes({ artist: related_artist, album: related_album })

    track.save!

    redirect_to tracks_path
  end

  def destroy
    Track.find(params[:id]).destroy!
  end

  private

  def track_params
    params.require(:track).permit(:file, :title)
  end

  def track_metadata
    @track_metadata ||= MetaExtractor.new(track_params[:file].path).perform
  end

  def related_artist_name
    track_metadata[:artist]
  end

  def related_artist
    @related_artist ||=
      Artist.find_by(name: related_artist_name) ||
      Artist.new(name: related_artist_name)
  end

  def related_album_params
    {
      title: track_metadata[:album],
      year: track_metadata[:year]
    }
  end

  def related_album
    @related_album ||=
      related_artist.albums.find_by(title: related_album_params[:title]) ||
      related_artist.albums.build(related_album_params)
  end

  def create_artist_if_needed
    related_artist.save! if related_artist.new_record?
  end

  def create_album_if_needed
    related_album.save! if related_album.new_record?
  end
end
