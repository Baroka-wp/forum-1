class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
    	t.string :tital
    	t.text :content
    	t.datetime :t_time
    	t.integer :user_id

      t.timestamps
    end
    add_index :topics , :user_id
  end
end
