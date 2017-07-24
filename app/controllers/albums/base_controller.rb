class Albums::BaseController < ApplicationController
  private

  def album
    @album ||= Album.find(params[:album_id])
  end
end
