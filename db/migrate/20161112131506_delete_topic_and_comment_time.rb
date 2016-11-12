class DeleteTopicAndCommentTime < ActiveRecord::Migration[5.0]
  def change
  	remove_column :topics , :t_time
  	remove_column :comments , :t_time
  end
end
