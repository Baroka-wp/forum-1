class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
    	t.text :c_content
    	t.datetime :c_time
    	t.integer :user_id
      t.timestamps
    end
    add_index :comments , :user_id
  end
end
