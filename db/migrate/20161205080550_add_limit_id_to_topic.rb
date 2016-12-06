class AddLimitIdToTopic < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics , :limit_id , :integer , :index => true
  end
end
