class TracksUploader < BaseUploader
  storage :file

  def extension_whitelist
    %w(mp3)
  end
end
