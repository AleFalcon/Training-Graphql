class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.integer :id_user, null: false
      t.string :encrypted_password, null: false, :default => ""
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end

    add_index :users, :email,                unique: true
    execute "CREATE SEQUENCE users_id_aut_incremen_seq OWNED BY
    users.id_user INCREMENT BY 1 START WITH 1"
  end
end
