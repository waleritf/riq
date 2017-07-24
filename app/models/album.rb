class Album < ApplicationRecord
  has_many :tracks, dependent: :destroy

  validates :title, presence: true
end
