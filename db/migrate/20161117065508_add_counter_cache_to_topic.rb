class AddCounterCacheToTopic < ActiveRecord::Migration[5.0]
  def change
  	remove_column :topics , :views 
  end
end
