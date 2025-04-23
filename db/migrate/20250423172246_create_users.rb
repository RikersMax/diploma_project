class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :user_name, limit: 64
      t.string :email, limit: 254
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email
  end
end
