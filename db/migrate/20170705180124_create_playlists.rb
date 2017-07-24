class CreatePlaylists < ActiveRecord::Migration[5.1]
  def change
    create_table :playlists do |t|
      t.string  :title,  null: false
      t.string  :file,   null: false
      t.boolean :on_air, null: false, default: false

      t.timestamps null: false
    end
  end
end
