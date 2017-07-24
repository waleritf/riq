class PlaylistFileGenerator
  HEADER = '#EXTM3U'
  INFO_PREFIX = '#EXTINF'

  attr_reader :playlist

  def initialize(playlist)
    @playlist = playlist
  end

  def perform
    Tempfile.open([playlist.title, '.m3u8']) do |f|
      f.write playlist_data
      playlist.file = f
    end.unlink

    playlist
  end

  private

  def playlist_data
    data = "#{HEADER}\n"

    playlist.tracks.each do |track|
      data += "#{INFO_PREFIX}:#{track.duration},#{track.artist.name} - #{track.title}\n"
      data += "#{track.file.path}\n"
    end

    data
  end
end
