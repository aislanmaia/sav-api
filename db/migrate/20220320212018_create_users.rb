class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :registry
      t.integer :role
      t.string :token

      t.timestamps
    end
    add_index :users, :token
    add_index :users, :email
    add_index :users, :registry
  end
end
