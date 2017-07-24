class Artists::AlbumsController < Artists::BaseController
  def index
    @albums = artist.albums
  end
end
