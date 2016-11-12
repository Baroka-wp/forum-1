class AddCommentTopicId < ActiveRecord::Migration[5.0]
  def change
  	add_column :comments , :topic_id , :integer
  	rename_column :topics, :tital, :title
  end
end
