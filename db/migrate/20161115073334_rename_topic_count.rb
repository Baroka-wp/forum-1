class RenameTopicCount < ActiveRecord::Migration[5.0]
  def change
  	rename_column :topics , :count , :comments_count
  end
end
