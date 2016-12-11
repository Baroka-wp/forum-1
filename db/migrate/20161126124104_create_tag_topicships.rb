class CreateTagTopicships < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_topicships do |t|
    	t.integer :tag_id , :index => true
    	t.integer :topic_id , :index => true
      t.timestamps
    end
  end
end
