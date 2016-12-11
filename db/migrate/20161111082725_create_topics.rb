class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
    	t.string :title
    	t.text :content
    	t.integer :user_id , :index => true
      t.integer :comments_count , default: 0
      t.integer :views_count , default: 0
      t.integer :likes_count , default: 0
      t.boolean :draft
      t.datetime :draft_time
      t.integer :limit_id , :index => true

      t.timestamps
    end
  end
end
