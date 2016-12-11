class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
    	t.attachment :images 
    	t.integer :topic_id , :index => true
      t.timestamps
    end
  end
end
