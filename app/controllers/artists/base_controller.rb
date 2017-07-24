class Artists::BaseController < ApplicationController
  private

  def artist
    @artist ||= Artist.find(params[:artist_id])
  end
end
