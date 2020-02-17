class CreatePurchasedAlbum < ActiveRecord::Migration[6.0]
  def change
    create_table :purchased_albums do |t|
      t.string :book_id, null: false
      t.string :book_title, null: false
      t.string :user_id, null: false

      t.timestamps
    end
  end
end
