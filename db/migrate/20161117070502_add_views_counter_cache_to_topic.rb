class AddViewsCounterCacheToTopic < ActiveRecord::Migration[5.0]
  def change
  	remove_column :topics , :comments_count
  end
end
