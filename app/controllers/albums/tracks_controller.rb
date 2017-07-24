class Albums::TracksController < Albums::BaseController
  def index
    @tracks = album.tracks
  end
end
