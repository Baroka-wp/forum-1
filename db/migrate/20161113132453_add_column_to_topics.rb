class AddColumnToTopics < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics , :category_id , :integer
    add_index :topics , :category_id
  end
end
