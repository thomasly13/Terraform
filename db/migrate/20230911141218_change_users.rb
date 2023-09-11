class ChangeUsers < ActiveRecord::Migration[7.0]
  def change

    add_index :users, :email, unique: true 
    add_index :users, :session_token, unique: true 
    add_index :users, :username, unique: true
  end
end
