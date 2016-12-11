class CreateCategoryTopicships < ActiveRecord::Migration[5.0]
  def change
    create_table :category_topicships do |t|
    	t.integer :category_id , :index => true
    	t.integer :topic_id , :index => true
      t.timestamps
    end
  end
end
