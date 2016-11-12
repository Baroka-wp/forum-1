class DeleteCommentTime < ActiveRecord::Migration[5.0]
  def change
  	remove_column :comments , :c_time
  end
end
