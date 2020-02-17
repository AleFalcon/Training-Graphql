class CreatePurchasedAlbum < ActiveRecord::Migration[6.0]
  def change
    create_table :purchased_albums do |t|
      t.string :album_id, null: false
      t.string :album_title, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
