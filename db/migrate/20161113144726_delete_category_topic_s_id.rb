class DeleteCategoryTopicSId < ActiveRecord::Migration[5.0]
  def change
  	remove_column :topics , :category_id
  	remove_column :categories , :topic_id
  end
end
