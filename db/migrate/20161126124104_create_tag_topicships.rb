class CreateTagTopicships < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_topicships do |t|
    	t.integer :tag_id
    	t.integer :topic_id
      t.timestamps
    end
    add_index :tag_topicships , :tag_id
    add_index :tag_topicships , :topic_id
  end
end
