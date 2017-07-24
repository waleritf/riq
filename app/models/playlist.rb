class Playlist < ApplicationRecord
  include ActiveModel::Validations

  has_and_belongs_to_many :tracks

  validates :title, presence: true
  validates_with AloneValidator, attribute: :on_air, value: true

  mount_uploader :file, PlaylistsUploader

  def self.on_air
    find_by(on_air: true)
  end
end
