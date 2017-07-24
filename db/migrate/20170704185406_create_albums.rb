class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.belongs_to :artist, index: true, foreign_key: true
      t.string     :title,  null: false, default: 'Unknown'
      t.integer    :year

      t.timestamps null: false
    end
  end
end
