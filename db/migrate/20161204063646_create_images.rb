class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
    	t.attachment :images , :image
    	t.integer :topic_id
      t.timestamps
    end
    add_index :images , :topic_id
    remove_attachment :topics, :avatar
  end
end
