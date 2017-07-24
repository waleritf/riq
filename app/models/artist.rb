class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :tracks, dependent: :destroy

  validates :name, presence: true
end
