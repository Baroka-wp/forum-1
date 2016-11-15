class CreateCategoryTopicships < ActiveRecord::Migration[5.0]
  def change
    create_table :category_topicships do |t|
    	t.integer :category_id
    	t.integer :topic_id
      t.timestamps
    end
    add_index :categories , :category_id 
    add_index :categories , :topic_id
  end
end
