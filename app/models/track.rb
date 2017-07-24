class Track < ApplicationRecord
  DEFAULT_TITLE = 'Unknown'

  belongs_to :artist
  belongs_to :album

  has_and_belongs_to_many :playlists

  validates :title, :file, :md5hash, :duration, :artist, presence: true
  validates :md5hash, uniqueness: true

  mount_uploader :file, TracksUploader

  before_validation :compute_hash

  private

  def compute_hash
    self.md5hash = Digest::MD5.hexdigest(self.file.read)
  end
end
