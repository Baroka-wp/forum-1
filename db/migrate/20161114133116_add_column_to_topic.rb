class AddColumnToTopic < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics , :count , :integer
  end
end
