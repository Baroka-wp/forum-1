class AddDraftColumnToTopicAndComment < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics , :draft , :boolean
  	add_column :comments , :draft , :boolean
  end
end
