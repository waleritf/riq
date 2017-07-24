class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.belongs_to :album,    index: true, foreign_key: true
      t.belongs_to :artist,   index: true, foreign_key: true
      t.string     :file,     null: false
      t.string     :md5hash,  null: false
      t.string     :title,    null: false
      t.integer    :duration, null: false, default: 0

      t.timestamps null: false
    end
  end
end
