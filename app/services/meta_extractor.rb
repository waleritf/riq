require 'taglib'

class MetaExtractor
  attr_reader :track_file

  def initialize(track_file)
    @track_file = track_file
  end

  def perform
    TagLib::FileRef.open(track_file) do |fileref|
      unless fileref.null?
        tag = fileref.tag
        properties = fileref.audio_properties

        {
          title: tag.title,
          artist: tag.artist,
          album: tag.album,
          year: tag.year,
          genre: tag.genre,
          duration: properties.length
        }
      end
    end
  end
end
