class PlaylistsUploader < BaseUploader
  storage :file

  def extension_whitelist
    %w(m3u m3u8)
  end
end
