class AddNicknameToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :nickname, :string
  	add_column :users, :role, :string
  	add_column :users, :fb_uid, :string , :index => true
    add_column :users, :fb_token, :string 
  	add_attachment :users, :avatar
  end
end
