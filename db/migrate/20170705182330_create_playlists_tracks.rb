class CreatePlaylistsTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :playlists_tracks do |t|
      t.belongs_to :playlist, index: true, foreign_key: true, null: false
      t.belongs_to :track, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
