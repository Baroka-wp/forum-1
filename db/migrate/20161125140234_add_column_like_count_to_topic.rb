class AddColumnLikeCountToTopic < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics , :likes_count , :integer , :default => 0
  end
  add_index :topics , :likes_count
end
