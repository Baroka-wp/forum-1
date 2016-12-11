class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
    	t.integer :user_id , :index => true
    	t.integer :friend_id , :index => true
      t.timestamps
    end
  end
end
