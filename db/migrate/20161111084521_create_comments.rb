class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
    	t.text :content
    	t.integer :user_id , :index => true
    	t.integer :topic_id , :index => true
    	t.boolean :draft
    	t.attachment :avatar

      t.timestamps
    end
  end
end
