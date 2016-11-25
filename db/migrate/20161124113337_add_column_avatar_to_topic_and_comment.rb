class AddColumnAvatarToTopicAndComment < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :topics, :avatar
  	add_attachment :comments, :avatar
  end
end
