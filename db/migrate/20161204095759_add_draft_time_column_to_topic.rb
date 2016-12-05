class AddDraftTimeColumnToTopic < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics , :draft_time , :datetime
  end
end
